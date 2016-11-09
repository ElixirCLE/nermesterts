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
    |> unique_constraint(:name)
  end

  @doc """
  Creates a query that orders players by name.
  """
  def ordered(query) do
    from p in query,
      order_by: p.name
  end

  @doc """
  Returns a query that gets all players whose active flag matches the passed in value.
  """
  def active(query, active) do
    from p in query,
      where: p.active == ^active
  end
end
