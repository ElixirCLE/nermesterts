defmodule Nermesterts.PlayerControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.User
  import Nermesterts.TestHelper, only: [log_in: 2]

  test "redirects to sign in page when not logged in", %{conn: conn} do
    user = insert(:user)
    conn = get conn, user_path(conn, :edit, user)
    assert redirected_to(conn) == session_path(conn, :new)
  end

  describe "while authenticated" do
    setup do
      user = insert(:user)
      conn = build_conn()
              |> log_in(user)
      {:ok, [conn: conn]}
    end

    test "activates chosen resource", %{conn: conn} do
      user = insert(:user)
      user = Repo.get!(User, user.id)
      refute user.active

      conn = put conn, player_activate_path(conn, :activate, user)
      assert redirected_to(conn) == page_path(conn, :index)

      user = Repo.get!(User, user.id)
      assert user.active
    end

    test "inactivates chosen resource", %{conn: conn} do
      user = insert(:user_active)
      user = Repo.get!(User, user.id)
      assert user.active

      conn = put conn, player_deactivate_path(conn, :deactivate, user)
      assert redirected_to(conn) == page_path(conn, :index)

      user = Repo.get!(User, user.id)
      refute user.active
    end

    test "adds a guest user", %{conn: conn} do
      refute Repo.get_by(User, %{guest: true})
      post conn, add_guest_path(conn, :add_guest)
      assert Repo.get_by!(User, %{guest: true})
    end

    test "removes a guest user", %{conn: conn} do
      user = insert(:user_guest)
      assert Repo.get_by!(User, %{guest: true})

      put conn, player_deactivate_path(conn, :deactivate, user)
      refute Repo.get_by(User, %{guest: true})
    end
  end
end
