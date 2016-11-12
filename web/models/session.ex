defmodule Nermesterts.Session do
  alias Nermesterts.Player

  def login(params, repo) do
    user = repo.get_by(Player, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Nermesterts.Repo.get(Player, id)
  end

  def current_user_name(conn) do
    player = current_user(conn)
    display_name(player)
  end

  def logged_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  defp display_name(player) when not is_nil(player) do
    player.name || player.username
  end
  defp display_name(_) do
    "Guest"
  end
end
