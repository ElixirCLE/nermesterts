defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Game
  alias Nermesterts.Player

  def index(conn, _params) do
    games = Nermesterts.Repo.all(Game)
    players = Nermesterts.Repo.all(Player)
    num_players = length(players)

    game = GamePicker.pick_game(games, num_players)
    game_is_nil = is_nil(game)

    phrase = Nermesterts.Repo.all(from p in Nermesterts.Phrase, where: p.has_token == not(^game_is_nil))
    |> Enum.take_random(1)
    |> List.first

    render conn, "index.html", game: game, players: players, phrase: phrase
  end
end
