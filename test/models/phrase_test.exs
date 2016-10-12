defmodule Nermesterts.PhraseTest do
  use Nermesterts.ModelCase

  alias Nermesterts.Phrase

  @valid_attrs %{has_token: true, message: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Phrase.changeset(%Phrase{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Phrase.changeset(%Phrase{}, @invalid_attrs)
    refute changeset.valid?
  end
end
