defmodule Nermesterts.Phrase do
  use Nermesterts.Web, :model

  schema "phrases" do
    field :message, :string
    field :has_token, :boolean, default: false

    timestamps()
  end

  @required_fields ~w(message has_token)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
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
