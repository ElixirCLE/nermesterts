defmodule Nermesterts.Repo.Migrations.RemoveAllPlayers do
  use Ecto.Migration

  def change do
    execute "DELETE FROM players"
  end
end
