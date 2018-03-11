defmodule Nermesterts.Game do
  use Nermesterts.Web, :model

  schema "games" do
    field :bgg_id, :integer
    field :name, :string
    field :min_players, :integer
    field :max_players, :integer
    field :image, :string

    many_to_many :users, Nermesterts.User, join_through: "user_games",
      join_keys: [game_id: :bgg_id, user_id: :id], unique: true,
      on_replace: :delete

    timestamps()
  end

  @required_fields ~w(name bgg_id min_players max_players)a
  @optional_fields ~w(image)a
  @all_fields @required_fields ++ @optional_fields

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    changeset = struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)

    # Pulled this out so that we can access the changes map
    changeset
    |> validate_number(:min_players, greater_than: 0)
    |> validate_number(:min_players,
                       less_than_or_equal_to: Map.get(changeset.changes, :max_players),
                       message: "Min players must be less than or equal to the max players.")
    |> unique_constraint(:bgg_id)
    |> unique_constraint(:unique_user_games_index)
  end

  @doc """
  Creates a query that orders games by name.
  """
  def ordered(query) do
    from g in query,
      order_by: g.name
  end
end
