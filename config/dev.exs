use Mix.Config

config :shorty, Shorty.Repo,
  database: "shorty_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :shorty, ecto_repos: [Shorty.Repo]
config :shorty, app_port: 4040
config :shorty, uri: "localhost:4040/urlx"
