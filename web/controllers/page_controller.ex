defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Player

  def index(conn, _params) do
    players = Nermesterts.Repo.all(Player)
    render conn, "index.html", game: nil, players: players
  end

  def post(conn, %{"player_info" => info}) do
    num_players = players(info)
    game = GamePicker.pick_game(GamePicker.games, num_players)
    players = Nermesterts.Repo.all(Player)
    render conn, "index.html", game: game, players: players
  end

  defp players(info) do
    case Integer.parse(info["number_of_players"]) do
      { players, _ } -> players
        _ -> 0
    end
  end
end
