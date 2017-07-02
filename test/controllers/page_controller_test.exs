defmodule Nermesterts.PageControllerTest do
  use Nermesterts.ConnCase
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


    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "Welcome to CoverMyTabletop!"
    end
  end
end
