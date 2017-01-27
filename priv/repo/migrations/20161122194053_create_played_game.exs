defmodule Nermesterts.Repo.Migrations.CreatePlayedGame do
  use Ecto.Migration

  def change do
    create table(:played_games) do
      add :year, :integer, null: false
      add :day, :integer, null: false
      add :player_count, :integer, null: false
      add :game_id, references(:games, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:played_games, [:game_id])
    create index(:played_games, [:year, :day, :player_count], unique: true)

  end
end
