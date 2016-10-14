defmodule Nermesterts.Repo.Migrations.AddActiveFieldToPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :active, :boolean, default: true
    end
  end
end
