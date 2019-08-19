defmodule Shorty.Repo.Migrations.CreateUrlx do
  use Ecto.Migration

  def up do
    create_if_not_exists table("urlx") do
      add :url, :string, null: false
      add :shortx, :string, null: false
      add :inserted_at, :utc_datetime, default: fragment("now()")
      add :visited_at, :utc_datetime
    end

    create_if_not_exists unique_index("urlx", [:url, :shortx])
    create_if_not_exists index("urlx", [:shortx])
  end

  def down do
    drop_if_exists index("urlx", [:shortx])
    drop_if_exists unique_index("urlx", [:url, :shortx])

    drop_if_exists table("urlx")
  end
end
