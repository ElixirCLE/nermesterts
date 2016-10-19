defmodule GamePicker.Randomizer do
  @moduledoc """
  A randomizer that can use the current date or a user-defined seed

  ## Examples
    iex> randomizer = GamePicker.Randomizer.new({2016, 10, 17})
    iex> games = [%Game{name: "Game1", min_players: 2, max_players: 4},
    ...> %Game{name: "Game2", min_players: 2, max_players: 4},
    ...> %Game{name: "Game3", min_players: 2, max_players: 4}]
    iex> GamePicker.pick_game(games, 3, randomizer)
    %Game{name: "Game2", min_players: 2, max_players: 4}
  """

  @doc """
  Picks a random element from the supplied list.
  """
  def randomize([], _, _), do: nil
  def randomize(list, year, day) when is_integer(year) and is_integer(day) do
    list
    |> Enum.at(rem(year * day, length(list)))
  end
  def randomize(_, _, _), do: nil

  def randomize(list) when is_list(list) do
    randomize(list, Timex.today.year, Timex.day(Timex.today))
  end
  def randomize(_), do: nil
end
