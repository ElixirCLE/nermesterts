defmodule Nermesterts.Repo.Migrations.RemoveUniqueGameName do
  use Ecto.Migration

  def change do
    drop unique_index(:games, [:name])
  end
end
