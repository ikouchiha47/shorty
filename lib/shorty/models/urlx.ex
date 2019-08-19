defmodule Shorty.Models.Urlx do
  @moduledoc """
    Model for urlx table
    has unique index on url and (shortx, url) column
  """

  use Ecto.Schema

  schema "urlx" do
    field :url, :string
    field :shortx, :string
    field :inserted_at, :utc_datetime
    field :visited_at, :utc_datetime
    field :short_url, :string, virtual: true
  end

  def changeset(urlx, params \\ %{}) do
    urlx
    |> Ecto.Changeset.cast(params, [:url, :shortx])
    |> Ecto.Changeset.validate_required([:url, :shortx])
    |> Ecto.Changeset.unique_constraint(:url)
    |> Ecto.Changeset.unique_constraint(:shortx)
  end

  defimpl Poison.Encoder, for: Shorty.Models.Urlx do
    def encode(urlx, options) do
      urlx = %Shorty.Models.Urlx{urlx | short_url: Shorty.Models.Urlx.short_url(urlx.shortx)}
      Poison.Encoder.Map.encode(Map.take(urlx, [:url, :short_url, :visited_at]), options)
    end
  end

  def short_url(shortx) do
    uri = Application.get_env(:shorty, :uri)
    "#{uri}/#{shortx}"
  end
end
