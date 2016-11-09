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
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_number(:min_players, greater_than: 0)
    |> validate_min_max_players
  end

  @doc """
  Creates a query that orders games by name.
  """
  def ordered(query) do
    from g in query,
      order_by: g.name
  end

  defp validate_min_max_players(changeset) do
    min = Map.get(changeset.changes, :min_players)
    max = Map.get(changeset.changes, :max_players)
    validate_min_max_players(changeset, min, max)
  end
  defp validate_min_max_players(changeset, min, max) when min > max do
    add_error(changeset, :min_players, "Min players must be less than or equal to the max players.")
  end
  defp validate_min_max_players(changeset, _, _), do: changeset
end
