defmodule Nermesterts.GameControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.Game
  import Nermesterts.TestHelper, only: [log_in: 2]

  @valid_attrs %{image: "some content", max_players: 42, min_players: 42, name: "some content", bgg_id: 1}
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
      {:ok, [conn: conn]}
    end

    test "lists all entries on index", %{conn: conn} do
      conn = get conn, game_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing games"
    end

    test "renders form for new resources", %{conn: conn} do
      conn = get conn, game_path(conn, :new)
      assert html_response(conn, 200) =~ "New game"
    end

    test "creates resource and redirects when data is valid", %{conn: conn} do
      conn = post conn, game_path(conn, :create), game: @valid_attrs
      assert redirected_to(conn) == game_path(conn, :index)
      assert Repo.get_by(Game, @valid_attrs)
    end

    test "does not create resource and renders errors when data is invalid", %{conn: conn} do
      conn = post conn, game_path(conn, :create), game: @invalid_attrs
      assert html_response(conn, 200) =~ "New game"
    end

    test "shows chosen resource", %{conn: conn} do
      game = Repo.insert! %Game{}
      conn = get conn, game_path(conn, :show, game)
      assert html_response(conn, 200) =~ "Show game"
    end

    test "renders page not found when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, game_path(conn, :show, -1)
      end
    end
  end
end
