use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :admin, Admin.Endpoint,
  http: [port: 4002],
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :website, Website.Endpoint,
  http: [port: 4002],
  server: false

# Configure your database
config :database, Database.Repo,
  username: "postgres",
  password: "postgres",
  database: "database_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
