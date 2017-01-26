defmodule Nermesterts.Plug.Authenticate do
  alias Nermesterts.Router.Helpers, as: Routes
  alias Nermesterts.{Repo, User}
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    assign_current_user(conn)
  end

  defp assign_current_user(conn = %Plug.Conn{}) do
    current_user = conn.assigns[:current_user] || Plug.Conn.get_session(conn, :current_user)
    assign_current_user(conn, current_user)
  end
  defp assign_current_user(conn, user = %User{}) do
    # Reload the current user from the database to pick up any changes
    user = Repo.get!(User, user.id)
    assign(conn, :current_user, user)
  end
  defp assign_current_user(conn, _), do: redirect_to_sign_in(conn)

  defp redirect_to_sign_in(conn) do
    conn
    |> Phoenix.Controller.put_flash(
         :error,
         'You need to be signed in to view this page'
       )
    |> Phoenix.Controller.redirect(to: Routes.session_path(conn, :new))
    |> halt
  end
end
