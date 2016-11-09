defmodule Nermesterts.Repo.Migrations.AddUniqueConstraintToPlayers do
  use Ecto.Migration

  def change do
    create unique_index(:players, [:name])
  end
end
