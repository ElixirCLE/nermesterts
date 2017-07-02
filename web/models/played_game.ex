defmodule Nermesterts.PlayedGame do
  use Nermesterts.Web, :model

  @required_fields ~w(year day player_count game_id)a
  @optional_fields ~w()a
  @all_fields @required_fields ++ @optional_fields

  schema "played_games" do
    field :year, :integer
    field :day, :integer
    field :player_count, :integer
    belongs_to :game, Nermesterts.Game

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:game_id)
    |> unique_constraint(:year_day_player_count)
  end
end
