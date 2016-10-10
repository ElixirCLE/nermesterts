defmodule Nermesterts.PageController do
  use Nermesterts.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", game: nil
  end

  def post(conn, %{"player_info" => info}) do
    players = String.to_integer(info["number_of_players"])
    case GamePicker.pick_game(GamePicker.games, players) do
      %{name: name} ->
        render conn, "index.html", game: name
      _ ->
        render conn, "index.html", game: nil
    end

  end
end
