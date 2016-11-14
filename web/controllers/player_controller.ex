defmodule Nermesterts.PlayerController do
  use Nermesterts.Web, :controller
  alias Nermesterts.User

  def activate(conn, %{"player_id" => id}) do
    update_user(conn, id, %{active: true})
  end

  def add_guest(conn, _params) do
    uuid = Ecto.UUID.generate
    guest_value = "guest-#{uuid}"
    changeset = User.registration_changeset(%User{}, %{name: "Guest", username: String.slice(guest_value, 0..19),
                                            password: guest_value, password_confirmation: guest_value, active: true, guest: true})
    Repo.insert!(changeset)

    conn
    |> redirect(to: page_path(conn, :index))
  end

  def deactivate(conn, %{"player_id" => id}) do
    update_user(conn, id, %{active: false})
  end

  def deactivate_all(conn, _params) do
    Repo.delete_all(User |> User.guest)
    Repo.update_all(User, set: [active: false])
    conn
    |> put_flash(:info, "Players cleared successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  defp update_user(conn, id, user_params) do
    user = Repo.get!(User, id)
    result = update_user_action(user, user_params, user.guest)
    case result do
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
  defp update_user_action(user, _, guest) when guest == true do
    Repo.delete(user)
  end
  defp update_user_action(user, user_params, _) do
    changeset = User.changeset(user, user_params)
    Repo.update(changeset)
  end
end
