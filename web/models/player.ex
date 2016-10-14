defmodule Nermesterts.Player do
  use Nermesterts.Web, :model

  schema "players" do
    field :name, :string
    field :active, :boolean, default: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :active])
    |> validate_required([:name])
  end
end
