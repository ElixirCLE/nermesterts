defmodule Nermesterts.RegistrationController do
  use Nermesterts.Web, :controller
  alias Nermesterts.User

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, changeset} ->
        # sign in
        conn
        |> put_session(:current_user, changeset.id)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        # show error
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
