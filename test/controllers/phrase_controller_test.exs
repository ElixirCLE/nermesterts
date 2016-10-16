defmodule Nermesterts.PhraseControllerTest do
  use Nermesterts.ConnCase

  alias Nermesterts.Phrase
  @valid_attrs %{message: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, phrase_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing phrases"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, phrase_path(conn, :new)
    assert html_response(conn, 200) =~ "New phrase"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, phrase_path(conn, :create), phrase: @valid_attrs
    assert redirected_to(conn) == phrase_path(conn, :index)
    assert Repo.get_by(Phrase, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, phrase_path(conn, :create), phrase: @invalid_attrs
    assert html_response(conn, 200) =~ "New phrase"
  end

  test "shows chosen resource", %{conn: conn} do
    phrase = Repo.insert! %Phrase{}
    conn = get conn, phrase_path(conn, :show, phrase)
    assert html_response(conn, 200) =~ "Show phrase"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, phrase_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    phrase = Repo.insert! %Phrase{}
    conn = get conn, phrase_path(conn, :edit, phrase)
    assert html_response(conn, 200) =~ "Edit phrase"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    phrase = Repo.insert! %Phrase{}
    conn = put conn, phrase_path(conn, :update, phrase), phrase: @valid_attrs
    assert redirected_to(conn) == phrase_path(conn, :show, phrase)
    assert Repo.get_by(Phrase, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    phrase = Repo.insert! %Phrase{}
    conn = put conn, phrase_path(conn, :update, phrase), phrase: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit phrase"
  end

  test "deletes chosen resource", %{conn: conn} do
    phrase = Repo.insert! %Phrase{}
    conn = delete conn, phrase_path(conn, :delete, phrase)
    assert redirected_to(conn) == phrase_path(conn, :index)
    refute Repo.get(Phrase, phrase.id)
  end
end
