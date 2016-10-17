defmodule GamePickerTest do
  use ExUnit.Case

  alias Nermesterts.Game
  alias GamePicker

  test "game selection is consistent when the day and number of players are the same" do
    games = [%Game{name: "Game1", min_players: 2, max_players: 4},
             %Game{name: "Game2", min_players: 2, max_players: 4},
             %Game{name: "Game3", min_players: 2, max_players: 4}]
    randomizer = GamePicker.Randomizer.new({2016, 10, 17})
    game = GamePicker.pick_game(games, 3, randomizer)
    assert game == %Game{name: "Game2", min_players: 2, max_players: 4}
  end
end
