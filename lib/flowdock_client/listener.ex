defmodule FlowdockClient.Listener do
  @api_token Application.get_env(:flowdock_client, :api_token)
  @org_name Application.get_env(:flowdock_client, :org_name)
  @callback_module Application.get_env(:flowdock_client, :callback_module)

  def start_link(flow_name) do
    GenServer.start_link(__MODULE__, %{bot_handler: @callback_module, flow: flow_name}, [name: :testy])
  end

  def init(%{flow: flow_name} = state) do
    {:ok, conn} = :shotgun.open('stream.flowdock.com', 443, :https)

    headers = %{
      'Accept' => 'text/event-stream',
      'Authorization' => prepare_auth_header(@api_token),
      'Cache-Control' => 'no-cache',
    }
    options = %{
      async: true,
      async_mode: :sse,
      handle_event: &(handle_event/3),
    }

    {:ok, response} = :shotgun.get(conn, "/flows/#{@org_name}/#{flow_name}", headers, options)

    {:ok, state}
  end

  def handle_event(_fin, _ref, msg) do
    with msg <- String.split(msg, "data:"),
         json_body <- List.last(msg),
         {:ok, json} <- Poison.decode(json_body) do
      # figure out how to pass in a pid instead of using a global hardcoded name
      GenServer.cast(:testy, {:handle_flowdock_message, json})
      :ok
    else
      _ -> nil
    end
  end

  def handle_cast({:handle_flowdock_message, message}, %{bot_handler: bot_handler} = state) do
    bot_handler.handle_flowdock_message(message)
    {:noreply, state}
  end

  defp prepare_auth_header(string) do
    auth_string = string |> Base.encode64
    "Basic #{auth_string}"
  end
end
