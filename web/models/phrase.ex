defmodule Nermesterts.Phrase do
  use Nermesterts.Web, :model

  schema "phrases" do
    field :message, :string
    field :has_token, :boolean, default: false

    timestamps()
  end

  @required_fields ~w(message has_token)a
  @optional_fields ~w()a
  @all_fields @required_fields ++ @optional_fields

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> generate_has_token
  end

  @doc """
  Creates a query that orders phrases by message.
  """
  def ordered(query) do
    from p in query,
      order_by: p.message
  end

  defp generate_has_token(changeset = %{changes: %{message: message}}) do
    changeset
    |> put_change(:has_token, String.contains?(message, "#GAME#"))
  end

  defp generate_has_token(c), do: c
end
