defmodule Nermesterts.PlayerController do
  use Nermesterts.Web, :controller
  alias Nermesterts.User

  def activate(conn, %{"player_id" => id}) do
    update_user(conn, id, %{active: true})
  end

  def deactivate(conn, %{"player_id" => id}) do
    update_user(conn, id, %{active: false})
  end

  def deactivate_all(conn, _params) do
    Repo.update_all(User, set: [active: false])
    conn
    |> put_flash(:info, "Players cleared successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  defp update_user(conn, id, user_params) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error while trying to update the player(s)")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
