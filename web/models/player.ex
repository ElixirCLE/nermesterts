defmodule Nermesterts.Player do
  use Nermesterts.Web, :model

  @required_fields ~w(username)
  @optional_fields ~w(name active)

  schema "players" do
    field :username, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :name, :string
    field :active, :boolean, default: false

    timestamps()
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_encrypted_pass
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:usernme, min: 3, max: 20)
    |> unique_constraint(:username, downcase: true)
  end

  @doc """
  Creates a query that orders players by name.
  """
  def ordered(query) do
    from p in query,
      order_by: p.name
  end

  @doc """
  Returns a query that gets all players whose active flag matches the passed in value.
  """
  def active(query, active) do
    from p in query,
      where: p.active == ^active
  end

  defp put_encrypted_pass(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :crypted_password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
