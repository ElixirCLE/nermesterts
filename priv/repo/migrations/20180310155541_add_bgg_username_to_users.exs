defmodule Nermesterts.Repo.Migrations.AddBggUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bgg_username, :string
    end
  end
end
