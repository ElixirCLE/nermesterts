defmodule Nermesterts.Session do
  alias Nermesterts.User

  def login(params, repo) do
    user = repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Nermesterts.Repo.get(User, id)
  end

  def current_user_name(conn) do
    user = current_user(conn)
    user_display_name(user)
  end

  def logged_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  defp user_display_name(user) when not is_nil(user) do
    User.display_name(user)
  end
  defp user_display_name(_) do
    "Guest"
  end
end
