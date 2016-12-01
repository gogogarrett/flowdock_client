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

## Example

Given the following callback module

```elixir
defmodule FdTrivia.ProcessMessage do
  def handle_flowdock_message(%{"app" => nil}), do: nil
  def handle_flowdock_message(%{"app" => "chat"} = msg) do
    IO.inspect(msg)
  end

  def handle_flowdock_message(_) do
    IO.inspect("catchall")
  end
end
```

Spin up an iex shell and spawn a new bot in the "trivia" channel

```bash
FlowdockClient.ListenerSup.add_bot("trivia")
```

Send some messages in the channel, and inspect the totally awesome IO in the shell.

```bash
iex(2)>
%{"app" => "chat", "attachments" => [], "content" => "Howdy",
  "created_at" => "2016-11-30T22:56:36.695Z", "event" => "message",
  "flow" => "abc", "id" => 311,
  "sent" => 1480546596695, "tags" => [],
  "thread" => %{"actions" => [], "activities" => 0, "body" => "",
    "created_at" => 1480546596695, "external_comments" => 0,
    "external_url" => nil, "fields" => [],
    "flow" => "abc",
    "id" => "123", "initial_message" => 311,
    "internal_comments" => 1, "status" => nil, "title" => "Howdy",
    "updated_at" => "2016-11-30T22:56:36.695Z"},
  "thread_id" => "123", "user" => "1111",
  "uuid" => "p34T15D6p7uI7I2J"}

%{"app" => "chat", "attachments" => [], "content" => "You're awesome!",
  "created_at" => "2016-11-30T22:56:39.242Z", "event" => "message",
  "flow" => "abc", "id" => 313,
  "sent" => 1480546599242, "tags" => [],
  "thread" => %{"actions" => [], "activities" => 0, "body" => "",
    "created_at" => 1480546599242, "external_comments" => 0,
    "external_url" => nil, "fields" => [],
    "flow" => "abc",
    "id" => "1234", "initial_message" => 313,
    "internal_comments" => 1, "status" => nil, "title" => "You're awesome!",
    "updated_at" => "2016-11-30T22:56:39.242Z"},
  "thread_id" => "1234", "user" => "1111",
  "uuid" => "rNIkyN9TL2-3LyOV"}

%{"app" => "chat", "attachments" => [], "content" => "Much cool",
  "created_at" => "2016-11-30T22:56:41.776Z", "event" => "message",
  "flow" => "abc", "id" => 315,
  "sent" => 1480546601776, "tags" => [],
  "thread" => %{"actions" => [], "activities" => 0, "body" => "",
    "created_at" => 1480546601776, "external_comments" => 0,
    "external_url" => nil, "fields" => [],
    "flow" => "abc",
    "id" => "12345", "initial_message" => 315,
    "internal_comments" => 1, "status" => nil, "title" => "Much cool",
    "updated_at" => "2016-11-30T22:56:41.776Z"},
  "thread_id" => "12345", "user" => "1111",
  "uuid" => "JIIo0-_I1rJh7ED1"}
```

With this message available to your callback module, you can handle the message however you see fit.


## Sending messages

```elixir
FlowdockClient.Sender.send_message("trivia", "Who was the first Orange president?")
```
