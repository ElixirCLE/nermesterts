defmodule Nermesterts.Phrase do
  use Nermesterts.Web, :model

  schema "phrases" do
    field :message, :string
    field :has_token, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message, :has_token])
    |> generate_has_token
    |> validate_required([:message, :has_token])
  end

  defp generate_has_token(changeset = %{changes: %{message: message}}) do
    changeset
    |> put_change(:has_token, String.contains?(message, "#GAME#"))
  end

  defp generate_has_token(c), do: c
end
