defmodule Nermesterts.Player do
  use Nermesterts.Web, :model

  @required_fields ~w(name)
  @optional_fields ~w(active)

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
    |> cast(params, @required_fields, @optional_fields)
  end
end
