defmodule Nermesterts.UserControllerTest do
  use Nermesterts.ConnCase
  alias Nermesterts.User

  @valid_attrs %{username: "foo"}
  @valid_create_attrs %{username: "foo", password: "barbaz", password_confirmation: "barbaz"}
  @invalid_attrs %{}
  @changeset User.registration_changeset(%User{}, @valid_create_attrs)

  test "renders form for editing chosen resource", %{conn: conn} do
    user = Repo.insert! @changeset
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user = Repo.insert! @changeset
    conn = put conn, user_path(conn, :update, user), user: @valid_create_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get_by(User, @valid_attrs)
  end

  @tag :pending
  # This tests will not work until we have actual required fields on an update page
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! @changeset
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! @changeset
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == page_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
