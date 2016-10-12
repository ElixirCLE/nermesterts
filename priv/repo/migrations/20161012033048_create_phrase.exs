defmodule Nermesterts.Repo.Migrations.CreatePhrase do
  use Ecto.Migration

  def change do
    create table(:phrases) do
      add :message, :string
      add :has_token, :boolean, default: false, null: false

      timestamps()
    end

  end
end
