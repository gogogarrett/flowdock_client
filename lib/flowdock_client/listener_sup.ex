defmodule FlowdockClient.ListenerSup do
  use Supervisor
  alias FlowdockClient.Listener

  def add_bot(flow_name) do
    Supervisor.start_child(__MODULE__, [flow_name])
  end

  defp list_flows do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.map(fn({_, pid, _, _}) -> pid end)
  end

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    [
      worker(Listener, [], restart: :transient)
    ]
    |> supervise(strategy: :simple_one_for_one)
  end
end
