use Mix.Config

config :shorty, Shorty.Repo,
  database: "shorty_repo_development",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :shorty, ecto_repos: [Shorty.Repo]
config :shorty, app_port: 4040
config :shorty, uri: "localhost:4040/urlx"

import_config "#{Mix.env}.exs"