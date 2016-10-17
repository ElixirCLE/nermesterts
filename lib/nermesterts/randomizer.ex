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
  Seeds the randomizer with the current date in the format of {year, month, day}
  """
  def new do
    :rand.seed(:exsplus, DateTime.utc_now |> DateTime.to_date |> Date.to_erl)
  end

  @doc """
  Seeds the randomizer with the supplied seed

  ## Examples
    iex> GamePicker.Randomizer.new({2016, 10, 17})
  """
  def new(seed) do
    :rand.seed(:exsplus, seed)
  end

  @doc """
  Picks a random element from the supplied list.
  """
  def randomize(list) do
    list
    |> Enum.take_random(1)
    |> List.first
  end
end
