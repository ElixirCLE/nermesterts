defmodule Nermesterts.PlayerController do
  use Nermesterts.Web, :controller
  alias Nermesterts.Player

  def new(conn, _params) do
    changeset = Player.changeset(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    changeset = Player.changeset(%Player{}, player_params)

    case Repo.insert(changeset) do
      {:ok, _player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def activate(conn, %{"player_id" => id}) do
    update_player(conn, id, %{active: true})
  end

  def deactivate(conn, %{"player_id" => id}) do
    update_player(conn, id, %{active: false})
  end

  def deactivate_all(conn, _params) do
    Repo.update_all(Player, set: [active: false])
    conn
    |> put_flash(:info, "Players cleared successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    update_player(conn, id, player_params)
  end

  def delete(conn, %{"id" => id}) do
    player = Repo.get!(Player, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  defp update_player(conn, id, player_params) do
    player = Repo.get!(Player, id)
    changeset = Player.changeset(player, player_params)

    case Repo.update(changeset) do
      {:ok, _player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end

  end
end
