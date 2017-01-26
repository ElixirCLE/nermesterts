defmodule Nermesterts.Plug.ViewAuthenticate do
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
    assign(conn, :current_user, Repo.get(User, user.id))
  end
  defp assign_current_user(conn, _) do
    assign(conn, :current_user, nil)
  end
end

