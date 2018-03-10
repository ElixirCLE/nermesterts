defmodule Nermesterts.Repo.Migrations.MakePlayerGamesUnique do
  use Ecto.Migration

  def change do
    create unique_index(:games, [:bgg_id])
  end
end
