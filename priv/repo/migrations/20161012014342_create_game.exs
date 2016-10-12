defmodule Nermesterts.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :min_players, :integer
      add :max_players, :integer
      add :image, :string

      timestamps()
    end

  end
end
