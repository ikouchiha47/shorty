defmodule Shorty.Controllers.Urls do
  @moduledoc """
    Controller
    Creates a shortened url for given url
    Returns the full url when shortend url is provided
  """

  def show(_conn, opts) do
    result = case Shorty.Repo.get_by(Shorty.Models.Urlx, shortx: opts[:id]) do
      nil -> nil
      urlx ->
        {:ok, datetime} = DateTime.now("Etc/UTC")

        %Shorty.Models.Urlx{urlx | visited_at: datetime}
        |> Shorty.Models.Urlx.changeset(%{})
        |> Shorty.Repo.update
    end

    case result do
      nil ->
        %Shorty.Response.Failure{errors: [%{id: "not found"}]}
      {:ok, urlex} ->
        %Shorty.Response.Success{data: urlex}
      {:error, changeset} ->
        %Shorty.Response.Failure{errors: changeset |> Shorty.Helpers.Error.translate_errors}
    end
  end

  def create(_conn, opts) do
    urlx = %Shorty.Models.Urlx{url: opts[:url], shortx: generate_shortcode()}
    changeset = Shorty.Models.Urlx.changeset(urlx, %{})

    case Shorty.Repo.insert(changeset) do
      {:ok, urlex} ->
        %Shorty.Response.Success{data: urlex}
      {:error, changeset} ->
        %Shorty.Response.Failure{errors: changeset |> Shorty.Helpers.Error.translate_errors}
    end
  end

  defp generate_shortcode do
    code = 6
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64()
      |> binary_part(0, 6)
      |> String.replace("-", "_")
    code
  end
end
