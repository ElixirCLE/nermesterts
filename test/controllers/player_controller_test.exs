defmodule Nermesterts.PlayerControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.User

  test "activates chosen resource", %{conn: conn} do
    user = Repo.insert! %User{username: "foo", crypted_password: "ABCDEF", active: false}
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Inactive players (1)"

    conn = put conn, player_activate_path(conn, :activate, user)
    assert redirected_to(conn) == page_path(conn, :index)

    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Active players (1)"
  end

  test "inactivates chosen resource", %{conn: conn} do
    user = Repo.insert! %User{username: "foo", crypted_password: "ABCDEF", active: true}
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Active players (1)"

    conn = put conn, player_deactivate_path(conn, :deactivate, user)
    assert redirected_to(conn) == page_path(conn, :index)

    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Inactive players (1)"
  end

end
