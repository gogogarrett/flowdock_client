defmodule FlowdockClient.Mixfile do
  use Mix.Project

  def project do
    [app: :flowdock_client,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :shotgun, :httpotion],
      mod: {FlowdockClient, []}]
  end

  defp deps do
    [
      {:shotgun, "~> 0.3.0"},
      {:poison, "~> 3.0"},
      {:httpotion, "~> 3.0.2"}
    ]
  end
end
