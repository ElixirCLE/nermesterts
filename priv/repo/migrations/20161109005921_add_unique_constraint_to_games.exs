defmodule Nermesterts.Repo.Migrations.AddUniqueConstraintToGames do
  use Ecto.Migration

  def change do
    create unique_index(:games, [:name])
  end
end
