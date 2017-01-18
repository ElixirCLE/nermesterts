defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Game
  alias Nermesterts.Phrase
  alias Nermesterts.User
  alias Nermesterts.GamePicker

  def index(conn, _params) do
    games = Repo.all(Game)
    active_players = User |> User.active(true) |> User.ordered |> Repo.all
    inactive_players = User |> User.active(false) |> User.ordered |> Repo.all
    guest_players = User |> User.guest |> Repo.all

    active_guest_players = active_players ++ guest_players
    num_players = length(active_guest_players)

    game = GamePicker.pick_game(games, num_players)
    game_is_nil = is_nil(game)

    phrase = Repo.all(from p in Phrase, where: p.has_token == not(^game_is_nil))
    |> Enum.take_random(1)
    |> List.first

    render conn, "index.html", game: game, active_players: active_guest_players, inactive_players: inactive_players, phrase: phrase
  end
end
