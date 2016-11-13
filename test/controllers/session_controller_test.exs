defmodule Nermesterts.SessionControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.User

  setup do
    User.registration_changeset(%User{}, %{username: "foo", password: "barbaz", password_confirmation: "barbaz"})
    |> Repo.insert
    {:ok, conn: build_conn()}
  end

  test "shows the login form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Log In"
  end

  test "creates a new user session for a valid user", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: %{username: "foo", password: "barbaz"}
    assert get_session(conn, :current_user)
    assert get_flash(conn, :info) == "Logged in"
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "does not create a session with a bad login", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: %{username: "foo", password: "bazbar"}
    refute get_session(conn, :current_user)
    assert get_flash(conn, :error) == "Wrong username or password"
  end

  test "does not create a session if user does not exist", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: %{username: "test", password: "barbaz"}
    assert get_flash(conn, :error) == "Wrong username or password"
  end
end
