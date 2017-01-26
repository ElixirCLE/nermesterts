defmodule Nermesterts.Repo.Migrations.RemoveRoles do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :role_id
    end

    drop table(:roles)
  end
end
