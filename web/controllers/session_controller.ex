defmodule Nermesterts.SessionController do
  use Nermesterts.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Nermesterts.Session.login(session_params, Nermesterts.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: page_path(conn, :index))
      :error ->
        conn
        |> put_flash(:error, "Wrong username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
