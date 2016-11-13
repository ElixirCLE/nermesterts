defmodule Nermesterts.Repo.Migrations.RenamePlayersToUsers do
  use Ecto.Migration

  def change do
    drop table(:players)

    create table(:users) do
      add :username, :string, null: false
      add :crypted_password, :string, null: false
      add :name, :string
      add :active, :boolean, default: false

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
