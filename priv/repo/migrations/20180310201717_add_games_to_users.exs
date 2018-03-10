defmodule Nermesterts.Repo.Migrations.AddGamesToUsers do
  use Ecto.Migration

  def change do
    create table(:user_games) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :game_id, references(:games, column: :bgg_id, on_delete: :delete_all)
    end

    create unique_index(:user_games, [:user_id, :game_id], name: :unique_user_games_index)
  end
end
