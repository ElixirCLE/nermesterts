# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nermesterts,
  ecto_repos: [Nermesterts.Repo]

# Configures the endpoint
config :nermesterts, Nermesterts.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CPMKKryMKV4WTYL1bPkGpvIgrvN1tXzCzYbAuwikds41pQ4zE5zJnCANL7wx5t2n",
  render_errors: [view: Nermesterts.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nermesterts.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :canary,
  repo: Nermesterts.Repo,
  not_found_handler: {Nermesterts.ControllerHelpers, :handle_resource_not_found}

config :boardgamegeek_client, :boardgamegeek_api, BoardGameGeek.HTTPClient
config :boardgamegeek_client, :boardgamegeek_html, BoardGameGeekHTML.HTTPClient

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
