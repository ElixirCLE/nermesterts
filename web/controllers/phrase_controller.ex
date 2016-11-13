defmodule Nermesterts.PhraseController do
  use Nermesterts.Web, :controller

  alias Nermesterts.Phrase

  def index(conn, _params) do
    phrases = Phrase |> Phrase.ordered |> Repo.all
    render(conn, "index.html", phrases: phrases)
  end

  def new(conn, _params) do
    changeset = Phrase.changeset(%Phrase{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"phrase" => phrase_params}) do
    changeset = Phrase.changeset(%Phrase{}, phrase_params)

    case Repo.insert(changeset) do
      {:ok, _phrase} ->
        conn
        |> put_flash(:info, "Phrase created successfully.")
        |> redirect(to: phrase_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    phrase = Repo.get!(Phrase, id)
    changeset = Phrase.changeset(phrase)
    render(conn, "edit.html", phrase: phrase, changeset: changeset)
  end

  def update(conn, %{"id" => id, "phrase" => phrase_params}) do
    phrase = Repo.get!(Phrase, id)
    changeset = Phrase.changeset(phrase, phrase_params)

    case Repo.update(changeset) do
      {:ok, _phrase} ->
        conn
        |> put_flash(:info, "Phrase updated successfully.")
        |> redirect(to: phrase_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", phrase: phrase, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phrase = Repo.get!(Phrase, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(phrase)

    conn
    |> put_flash(:info, "Phrase deleted successfully.")
    |> redirect(to: phrase_path(conn, :index))
  end
end
