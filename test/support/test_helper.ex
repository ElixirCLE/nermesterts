defmodule Nermesterts.TestHelper do
  require Phoenix.ConnTest

  def log_in(conn, user) do
    conn |> Plug.Conn.assign(:current_user, user)
  end
end
