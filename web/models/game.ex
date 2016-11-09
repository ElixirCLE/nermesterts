defmodule Nermesterts.Game do
  use Nermesterts.Web, :model

  schema "games" do
    field :name, :string
    field :min_players, :integer
    field :max_players, :integer
    field :image, :string

    timestamps()
  end

  @required_fields ~w(name min_players max_players)
  @optional_fields ~w(image)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    changeset = struct
    |> cast(params, @required_fields, @optional_fields)

    # Pulled this out so that we can access the changes map
    changeset
    |> validate_number(:min_players, greater_than: 0)
    |> validate_number(:min_players,
                       less_than_or_equal_to: Map.get(changeset.changes, :max_players),
                       message: "Min players must be less than or equal to the max players.")
    |> unique_constraint(:name)
  end

  @doc """
  Creates a query that orders games by name.
  """
  def ordered(query) do
    from g in query,
      order_by: g.name
  end
end
