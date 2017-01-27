defmodule Nermesterts.Repo.Migrations.SetAdminFalse do
  use Ecto.Migration

  def up do
    execute "UPDATE users SET admin = FALSE where admin IS NULL"

    alter table(:users) do
      modify :admin, :boolean, null: false, default: false
    end
  end

  def down do
    alter table(:users) do
      modify :admin, :boolean, null: true, default: nil
    end
  end
end
