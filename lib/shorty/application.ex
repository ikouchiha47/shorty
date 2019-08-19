defmodule Shorty.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Shorty.Repo
    ]

    children = case Application.get_env(:shorty, :minimal) do
      true -> children
      _ -> [ { Plug.Cowboy, scheme: :http, plug: Shorty.Router, options: [port: app_port()] } | children]
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shorty.Supervisor]

    Logger.info("Starting application at port #{app_port()}")
    Supervisor.start_link(children, opts)
  end

  defp app_port do
    Application.get_env(:shorty, :app_port, 4040)
  end
end
