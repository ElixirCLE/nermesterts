defmodule Nermesterts.GamePicker do
  @moduledoc """
  Choose a game that matches criteria

  ## Examples
      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 4, max_players: 10},
      ...> %Nermesterts.Game{name: "Game3", min_players: 6, max_players: 12}]
      iex> Nermesterts.GamePicker.pick_game(games, 5)
      %Nermesterts.Game{name: "Game2", min_players: 4, max_players: 10}
  """

  @doc """
  Picks a random game from the list. By default, the randomizer is seeded with the current date
  Returns a `%Game{}` where min_players <= num_players <= max_players.

  ## Examples
      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 4, max_players: 10},
      ...> %Nermesterts.Game{name: "Game3", min_players: 6, max_players: 12}]
      iex> Nermesterts.GamePicker.pick_game(games, 5)
      %Nermesterts.Game{name: "Game2", min_players: 4, max_players: 10}

      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4}]
      iex> Nermesterts.GamePicker.pick_game(games, 1)
      nil
  """
  def pick_game(games_list, num_players, randomizer \\ GamePicker.Randomizer) do
    games_list
    |> filter_min_players(num_players)
    |> filter_max_players(num_players)
    |> randomizer.randomize
  end

  @doc """
  Filtes a list of games by the minimum number of players.
  Returns a filtered list of `%Game{}`s.

  ## Examples
      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
      iex> Nermesterts.GamePicker.filter_min_players(games, 2)
      [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4}]

      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
      iex> Nermesterts.GamePicker.filter_min_players(games, 3)
      [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4}, %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
  """
  def filter_min_players(games_list, num_players) do
    Enum.filter(games_list, fn(game) -> Map.get(game, :min_players) <= num_players end)
  end

  @doc """
  Filters a list of games by the maximum number of players.
  Returns a filtered list of `%Game{}`s.

  ## Examples
      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 0},
      ...> %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 2}]
      iex> Nermesterts.GamePicker.filter_max_players(games, 5)
      [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 0}]

      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
      iex> Nermesterts.GamePicker.filter_max_players(games, 5)
      [%Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]

      iex> games = [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4},
      ...> %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
      iex> Nermesterts.GamePicker.filter_min_players(games, 4)
      [%Nermesterts.Game{name: "Game1", min_players: 2, max_players: 4}, %Nermesterts.Game{name: "Game2", min_players: 3, max_players: 5}]
  """
  def filter_max_players(games_list, num_players) do
    games_list
    |> Enum.filter(fn(game) -> game_within_max_boundry(game, num_players) end)
  end

  defp game_within_max_boundry(%{max_players: 0}, _) do
    true
  end

  defp game_within_max_boundry(game, num_players) do
    Map.get(game, :max_players) >= num_players
  end
end
