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
    |> validate_required([:message, :has_token])
  end
end
