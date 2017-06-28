defmodule Nermesterts.GameController do
  use Nermesterts.Web, :controller
  require BoardGameGeekClient

  alias Nermesterts.Game

  def index(conn, _params) do
    games = Game |> Game.ordered |> Repo.all
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = Game.changeset(%Game{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    changeset = Game.changeset(%Game{}, game_params)

    case Repo.insert(changeset) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render(conn, "show.html", game: game)
  end

  def delete(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end

  def search(conn, %{"q" => query}) do
    results = BoardGameGeekClient.search_games(query)
    |> Enum.map(fn %{id: id, name: name} -> %{id: id, text: name} end)

    render conn, "games_search.json", results: results
  end
  def search(conn, %{"id" => id}) do
    result = BoardGameGeekClient.get_games_info([id])
    render conn, "games_info.json", result: result
  end
end
