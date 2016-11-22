defmodule Nermesterts.PlayedGame do
  use Nermesterts.Web, :model

  @required_params ~w(year day player_count game_id)
  @optional_params ~w()

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
    |> cast(params, @required_params, @optional_params)
    |> foreign_key_constraint(:game_id)
    |> unique_constraint(:year_day_player_count)
  end
end
