use Mix.Config

config :shorty, Shorty.Repo,
  database: "shorty_repo",
  username: "postgres",
  password: "",
  hostname: "localhost",
  pool_size: 20

config :shorty, ecto_repos: [Shorty.Repo]
config :shorty, app_port: 8080
config :shorty, uri: "localhost:8080/urlx"