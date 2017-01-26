defmodule Nermesterts.UserControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.User
  import Nermesterts.TestHelper, only: [log_in: 2]

  @valid_attrs %{username: "foo"}
  @valid_create_attrs %{username: "foo", password: "barbaz", password_confirmation: "barbaz"}
  @invalid_attrs %{}

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
      {:ok, [conn: conn, logged_in_user: user]}
    end

    test "renders form for editing chosen resource", %{conn: conn, logged_in_user: user} do
      conn = get conn, user_path(conn, :edit, user)
      assert html_response(conn, 200) =~ "Edit user"
    end

    test "updates chosen resource and redirects when data is valid", %{conn: conn, logged_in_user: user} do
      conn = put conn, user_path(conn, :update, user), user: @valid_create_attrs
      assert redirected_to(conn) == page_path(conn, :index)
      assert Repo.get_by(User, @valid_attrs)
    end

    @tag :pending
    # This tests will not work until we have actual required fields on an update page
    test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, logged_in_user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit user"
    end

    test "deletes chosen resource", %{conn: conn, logged_in_user: user} do
      conn = delete conn, user_path(conn, :delete, user)
      assert redirected_to(conn) == page_path(conn, :index)
      refute Repo.get(User, user.id)
    end
  end
end
