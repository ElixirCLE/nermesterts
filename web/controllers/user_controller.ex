defmodule Nermesterts.UserController do
  use Nermesterts.Web, :controller
  alias Nermesterts.User
  import Nermesterts.ControllerHelpers

  plug :load_and_authorize_resource, model: User

  def edit(conn, _params) do
    if conn.assigns.authorized do
      user = conn.assigns.user
      changeset = User.changeset(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    else
      redirect_not_authorized(conn, page_path(conn, :index))
    end
  end

  def update(conn, %{"user" => user_params}) do
    if conn.assigns.authorized do
      user = conn.assigns.user
      changeset = User.changeset(user, user_params)

      case Repo.update(changeset) do
        {:ok, _user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: page_path(conn, :index))
        {:error, changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    else
      redirect_not_authorized(conn, page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    if conn.assigns.authorized do
      user = conn.assigns.user

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(user)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: page_path(conn, :index))
    else
      redirect_not_authorized(conn, page_path(conn, :index))
    end
  end
end
