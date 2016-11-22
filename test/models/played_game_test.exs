defmodule Nermesterts.PlayedGameTest do
  use Nermesterts.ModelCase

  alias Nermesterts.PlayedGame

  @valid_attrs %{day: 42, year: 42, player_count: 6, game_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PlayedGame.changeset(%PlayedGame{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PlayedGame.changeset(%PlayedGame{}, @invalid_attrs)
    refute changeset.valid?
  end
end
