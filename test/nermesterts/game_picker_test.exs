defmodule GamePickerTest do
  use ExUnit.Case
  doctest Nermesterts.GamePicker

  alias Nermesterts.Game
  alias Nermesterts.GamePicker

  test "game selection is consistent when the day and number of players are the same" do
    games = [%Game{name: "Game1", min_players: 2, max_players: 4},
             %Game{name: "Game2", min_players: 2, max_players: 4},
             %Game{name: "Game3", min_players: 2, max_players: 4}]
    assert GamePicker.pick_game(games, 3) == GamePicker.pick_game(games, 3)
  end
end
