defmodule Nermesterts.Repo.Migrations.AddBggIdToGames do
  use Ecto.Migration

  def change do
    alter table(:games) do
      add :bgg_id, :integer
    end
  end
end
