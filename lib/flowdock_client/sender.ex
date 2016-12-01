defmodule FlowdockClient.Sender do
  @api_token Application.get_env(:flowdock_client, :api_token)
  @org_name Application.get_env(:flowdock_client, :org_name)

  def send_message(flow, message) do
    HTTPotion.post(
      "https://api.flowdock.com/flows/#{@org_name}/#{flow}/messages",
      [
        body: "event=message&content=#{message}",
        headers: ["Content-Type": "application/x-www-form-urlencoded", "Authorization": prepare_auth_header(@api_token)]
      ]
    )
  end

  defp prepare_auth_header(string) do
    auth_string = string |> Base.encode64
    "Basic #{auth_string}"
  end
end
