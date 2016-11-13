defmodule Nermesterts.UserTest do
  use Nermesterts.ModelCase

  alias Nermesterts.User

  @valid_attrs %{username: "foo", password: "barbaz", password_confirmation: "barbaz", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "crypted_password value gets set to a hash" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :crypted_password))
  end

  test "crypted_digest value does not get set if password is nil" do
    changeset = User.registration_changeset(%User{}, %{password: nil, password_confirmation: nil, username: "foo"})
    refute changeset.valid?
    refute Ecto.Changeset.get_change(changeset, :crypted_password)
  end
end
