defmodule Nermesterts.Factory do
  use ExMachina.Ecto, repo: Nermesterts.Repo
  alias Nermesterts.User
  alias Nermesterts.Game

  def user_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456",
      games: [build(:game)]
    }
  end

  def user_admin_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456",
      admin: true,
      games: [build(:game)]
    }
  end

  def user_with_password_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      password: "123456",
      password_confirmation: "123456",
      crypted_password: Comeonin.Bcrypt.hashpwsalt("123456"),
      games: [build(:game)]
    }
  end

  def user_active_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456",
      active: true,
      games: [build(:game)]
    }
  end

  def user_guest_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456",
      guest: true,
      games: [build(:game)]
    }
  end

  def game_factory do
    %Game{
      bgg_id: sequence(:bgg_id, &"#{&1}") |> String.to_integer,
      name: "Zombicide: Invader",
      min_players: 1,
      max_players: 6,
      image: "/tmp"
    }
  end
end
