defmodule Nermesterts.RegistrationController do
  use Nermesterts.Web, :controller

  alias Nermesterts.Player

  def new(conn, _params) do
    changeset = Player.changeset(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    changeset = Player.changeset(%Player{}, player_params)

    case Nermesterts.Player.create(changeset, Nermesterts.Repo) do
      {:ok, _changeset} ->
        # sign in
        conn
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        # show error
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end
end
