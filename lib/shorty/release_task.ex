defmodule Shorty.ReleaseTask do
  @repo_module Shorty.Repo
  @app :shorty


  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()

    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end

  # defp start_app do
  #   load_app()
  #   Application.put_env(@app, :minimal, true)
  #   case Application.ensure_all_started(@app) do
  #     {:error, term} -> IO.inspect(term)
  #     :ok -> :ok
  #   end
  # end
end