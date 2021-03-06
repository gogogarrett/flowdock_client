defmodule FlowdockClient do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(FlowdockClient.ListenerSup, []),
    ]

    opts = [strategy: :one_for_one, name: FlowdockClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
