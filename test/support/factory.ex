defmodule Nermesterts.Factory do
  use ExMachina.Ecto, repo: Nermesterts.Repo
  alias Nermesterts.User

  def user_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456"
    }
  end

  def user_admin_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      crypted_password: "123456",
      admin: true
    }
  end

  def user_with_password_factory do
    %User{
      username: sequence(:username, &"username #{&1}"),
      password: "123456",
      password_confirmation: "123456",
      crypted_password: Comeonin.Bcrypt.hashpwsalt("123456")
    }
  end
end
