# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :admin,
  ecto_repos: [Admin.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :admin, Admin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3VhsC8PT77UphkSJU+h7Ej2/L974Uy0+ahXMS7WZHEOAoNX02WeOGsY5oH/y3/Py",
  render_errors: [view: Admin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Admin.PubSub, adapter: Phoenix.PubSub.PG2]

config :website,
  ecto_repos: [Website.Repo],
  generators: [context_app: false]

# Configures the endpoint
config :website, Website.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EzzgGwZLlu9ZboXGjjqSfHTR2IF6Gl67PfGYAa6wLz1qYdABIjtgU/JUINfj54Yi",
  render_errors: [view: Website.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Website.PubSub, adapter: Phoenix.PubSub.PG2]

# Configure Mix tasks and generators
config :database,
  ecto_repos: [Database.Repo]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
