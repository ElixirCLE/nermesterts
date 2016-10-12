defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Game
  alias Nermesterts.Player

  def index(conn, _params) do
    games = Nermesterts.Repo.all(Game)
    players = Nermesterts.Repo.all(Player)
    num_players = length(players)
    game = GamePicker.pick_game(games, num_players)
    render conn, "index.html", game: game, players: players
  end
end
