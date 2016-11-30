# FlowdockClient

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `flowdock_client` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:flowdock_client, "~> 0.1.0"}]
    end
    ```

  2. Ensure `flowdock_client` is started before your application:

    ```elixir
    def application do
      [applications: [:flowdock_client]]
    end
    ```

  3. Add the follow config to your app:

    ```elixir
    config :flowdock_client,
      api_token: "abc-token-here-123",
      org_name: "blake",
      callback_module: FdTrivia.ProcessMessage
    ```
