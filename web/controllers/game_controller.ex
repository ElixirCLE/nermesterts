defmodule Nermesterts.GameController do
  use Nermesterts.Web, :controller
  require BoardGameGeekClient

  alias Nermesterts.Game
  alias Nermesterts.User

  def index(conn, _params) do
    games = Game |> Game.ordered |> Repo.all |> Repo.preload(:users)
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = Game.changeset(%Game{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    bgg_id = Map.get(game_params, "bgg_id") || -1
    existing_game = Repo.get_by(Game, bgg_id: bgg_id)
    create(conn, game_params, existing_game)
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render(conn, "show.html", game: game)
  end

  def delete(conn, %{"id" => id}) do
    user = Nermesterts.Session.current_user(conn)
    game = Repo.get!(Game, id) |> Repo.preload(:users)
    new_users = game.users -- [user]
                |> Enum.map(&Ecto.Changeset.change/1)

    game
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:users, new_users)
    |> Repo.update!
    IO.puts "Updated"

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end

  def search(conn, %{"q" => query}) do
    results = BoardGameGeekClient.search_games(query)
    render conn, "games_search.json", results: results
  end
  def search(conn, %{"id" => id}) do
    result = BoardGameGeekClient.get_games_info([id])
    render conn, "games_info.json", result: result
  end

  defp create(conn, game_params, nil) do
    changeset = Game.changeset(%Game{}, game_params)

    case Repo.insert(changeset) do
      {:ok, game} ->
        add_game_to_user(conn, game)

        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  defp create(conn, _game_params, existing_game) do
    add_game_to_user(conn, existing_game)

    conn
    |> put_flash(:info, "Game created successfully.")
    |> redirect(to: game_path(conn, :index))
  end

  defp add_game_to_user(conn, %Game{} = game) do
    user = Nermesterts.Session.current_user(conn)
           |> Repo.preload(:games)
    game = game
           |> Repo.preload(:users)
    add_game_to_user(game, user, Enum.member?(game.users, user))
  end

  defp add_game_to_user(game, %User{} = user, false) do
    new_users = game.users ++ [user]
                |> Enum.map(&Ecto.Changeset.change/1)
    game
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:users, new_users)
    |> Repo.update!
  end
  defp add_game_to_user(game, _, true) do
    game
  end
end
