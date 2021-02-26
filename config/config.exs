# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rp7pay,
  ecto_repos: [Rp7pay.Repo]

# Configures the endpoint
config :rp7pay, Rp7payWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/yphBVmKxGsol9/6lIoZicug4u3lPI8unBTi4/R2EHG1beyq87AdeF6nE7B0x1kG",
  render_errors: [view: Rp7payWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rp7pay.PubSub,
  live_view: [signing_salt: "RcTrGm5N"]

  # Configures repository
config :rp7pay, Rp7pay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :rp7pay, :basic_auth,
  username: "banana",
  password: "1234"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
