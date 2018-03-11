defmodule Nermesterts.GameTest do
  use Nermesterts.ModelCase

  alias Nermesterts.Game
  alias Nermesterts.Repo
  alias Nermesterts.User

  @valid_attrs %{image: "some content", max_players: 42, min_players: 42, name: "some content", bgg_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Game.changeset(%Game{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Game.changeset(%Game{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "user games are unique" do
    {:ok, user} = User.registration_changeset(%User{}, %{username: "foo", password: "barbaz", password_confirmation: "barbaz"})
           |> Repo.insert

    user = user |> Repo.preload(:games)

    {:ok, game} = Game.changeset(%Game{}, @valid_attrs)
                  |> Repo.insert
    game
    |> Repo.preload(:users)
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update

    {:error, changeset} = Game.changeset(%Game{}, @valid_attrs)
                  |> Repo.insert

    assert {"has already been taken", []} = changeset.errors[:bgg_id]
    refute changeset.valid?
  end
end
