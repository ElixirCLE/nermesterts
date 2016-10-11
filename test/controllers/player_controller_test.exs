defmodule Nermesterts.PlayerControllerTest do
  use Nermesterts.ConnCase

  alias Nermesterts.Player
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, player_path(conn, :new)
    assert html_response(conn, 200) =~ "New player"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, player_path(conn, :create), player: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get_by(Player, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, player_path(conn, :create), player: @invalid_attrs
    assert html_response(conn, 200) =~ "New player"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    player = Repo.insert! %Player{}
    conn = get conn, player_path(conn, :edit, player)
    assert html_response(conn, 200) =~ "Edit player"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    player = Repo.insert! %Player{}
    conn = put conn, player_path(conn, :update, player), player: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get_by(Player, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    player = Repo.insert! %Player{}
    conn = put conn, player_path(conn, :update, player), player: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit player"
  end

  test "deletes chosen resource", %{conn: conn} do
    player = Repo.insert! %Player{}
    conn = delete conn, player_path(conn, :delete, player)
    assert redirected_to(conn) == page_path(conn, :index)
    refute Repo.get(Player, player.id)
  end
end
