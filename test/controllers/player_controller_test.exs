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

  test "adds a guest user", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Active players (0)"

    conn = post conn, add_guest_path(conn, :add_guest)
    assert redirected_to(conn) == page_path(conn, :index)

    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "<td>Guest</td>"
  end

  @tag :pending
  # This test will not work without being logged in. May also want xmerl for HTML parsing to find the ID
  test "removes a guest user", %{conn: conn} do
    conn = post conn, add_guest_path(conn, :add_guest)
    assert redirected_to(conn) == page_path(conn, :index)

    conn = get conn, page_path(conn, :index)
    response = html_response(conn, 200)
    assert response =~ "Active players (1)"
    IO.inspect(response)
    guest_id = List.first(Regex.run(~r{\d+}, response))

    conn = put conn, player_deactivate_path(conn, :deactivate, %User{id: guest_id})
    assert redirected_to(conn) == page_path(conn, :index)

    conn = get conn, page_path(conn, :index)
    refute html_response(conn, 200) =~ "<td>Guest</td>"
  end

end
