defmodule Nermesterts.Game do
  use Nermesterts.Web, :model

  schema "games" do
    field :name, :string
    field :min_players, :integer
    field :max_players, :integer
    field :image, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :min_players, :max_players, :image])
    |> validate_required([:name, :min_players, :max_players, :image])
  end
end
