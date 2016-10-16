defmodule Nermesterts.PhraseTest do
  use Nermesterts.ModelCase

  alias Nermesterts.Phrase

  @valid_attrs %{message: "some content"}
  @invalid_attrs %{}
  @valid_substitutable %{message: "substitute #GAME#"}

  test "changeset with valid attributes" do
    changeset = Phrase.changeset(%Phrase{}, @valid_attrs)
    assert changeset.valid?
    assert :error = fetch_change(changeset, :has_token)
  end

  test "changeset with invalid attributes" do
    changeset = Phrase.changeset(%Phrase{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with valid substitutable message" do
    changeset = Phrase.changeset(%Phrase{}, @valid_substitutable)
    assert changeset.valid?
    assert changeset.changes.has_token
  end
end
