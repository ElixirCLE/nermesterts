defmodule Nermesterts.Repo.Migrations.RemoveUniquePlayerName do
  use Ecto.Migration

  def change do
    drop index(:players, [:name])
  end
end
