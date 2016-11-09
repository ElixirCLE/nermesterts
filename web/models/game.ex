defmodule Nermesterts.Game do
  use Nermesterts.Web, :model

  schema "games" do
    field :name, :string
    field :min_players, :integer
    field :max_players, :integer
    field :image, :string

    timestamps()
  end

  @required_fields ~w(name, min_playrs, max_players)
  @optional_fields ~w(image)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end

  @doc """
  Creates a query that orders games by name.
  """
  def ordered(query) do
    from g in query,
      order_by: g.name
  end
end
