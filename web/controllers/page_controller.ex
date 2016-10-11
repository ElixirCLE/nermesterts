defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", game: nil
  end

  def post(conn, %{"player_info" => info}) do
    players = players(info)
    game = GamePicker.pick_game(GamePicker.games, players)
    render conn, "index.html", game: game
  end

  defp players(info) do
    case Integer.parse(info["number_of_players"]) do
      { players, _ } -> players
        _ -> 0
    end
  end
end
