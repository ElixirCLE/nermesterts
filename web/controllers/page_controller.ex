defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Game
  alias Nermesterts.Phrase
  alias Nermesterts.Player
  alias Nermesterts.GamePicker

  def index(conn, _params) do
    games = Nermesterts.Repo.all(Game)
    active_players = Nermesterts.Repo.all(from p in Player, where: p.active == true)
    inactive_players = Nermesterts.Repo.all(from p in Player, where: p.active == false)
    num_players = length(active_players)

    game = GamePicker.pick_game(games, num_players)
    game_is_nil = is_nil(game)

    phrase = Nermesterts.Repo.all(from p in Phrase, where: p.has_token == not(^game_is_nil))
    |> Enum.take_random(1)
    |> List.first

    render conn, "index.html", game: game, active_players: active_players, inactive_players: inactive_players, phrase: phrase
  end
end
