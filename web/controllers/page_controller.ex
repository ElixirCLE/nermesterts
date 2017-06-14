defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.{Game, GamePicker, Phrase, PlayedGame, User}

  def index(conn, _params) do
    active_players = User |> User.active(true) |> User.ordered |> Repo.all
    inactive_players = User |> User.active(false) |> User.ordered |> Repo.all
    guest_players = User |> User.guest |> Repo.all

    active_guest_players = active_players ++ guest_players
    num_players = length(active_guest_players)

    played_game = Repo.get_by(PlayedGame, player_count: num_players, year: Timex.today.year, day: Timex.day(Timex.today))
    game = get_game(played_game, num_players)
    game_is_nil = is_nil(game)

    phrase = Repo.all(from p in Phrase, where: p.has_token == not(^game_is_nil))
    |> Enum.take_random(1)
    |> List.first

    render conn, :index, game: game, active_players: active_guest_players, inactive_players: inactive_players, phrase: phrase
  end

  defp get_game(game, _) when not is_nil(game) do
    Repo.get!(Game, game.game_id)
  end
  defp get_game(_, num_players) do
    # Get game from previous day (same number of players?) and remove it from the list of games the picker can choose from
    yesterday = Timex.shift(Timex.today, days: -1)
    prev_game = Repo.get_by(PlayedGame, player_count: num_players, year: yesterday.year, day: Timex.day(yesterday))
    games = filtered_games(prev_game)

    GamePicker.pick_game(games, num_players)
    |> insert_played_game(num_players)
  end

  defp filtered_games(prev_game) when not is_nil(prev_game) do
    Repo.all(from g in Game, where: g.id != ^prev_game.game_id)
  end
  defp filtered_games(_) do
    Repo.all(Game)
  end

  defp insert_played_game(game, num_players) when not is_nil(game) do
    changeset = PlayedGame.changeset(%PlayedGame{}, %{game_id: game.id, player_count: num_players, year: Timex.today.year, day: Timex.day(Timex.today)})
    Repo.insert(changeset)
  end
  defp insert_played_game(_, _) do
    nil
  end
end
