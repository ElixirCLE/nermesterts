defmodule Nermesterts.User do
  use Nermesterts.Web, :model

  @required_fields ~w(username)
  @optional_fields ~w(name active)

  schema "users" do
    field :username, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :name, :string
    field :active, :boolean, default: false

    belongs_to :role, Nermesterts.Role

    timestamps()
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password password_confirmation), [])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> put_encrypted_pass
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint(:username, downcase: true)
  end

  def display_name(user) do
    display_name(user.username, user.name)
  end
  defp display_name(_, name) when not is_nil(name) do
    name
  end
  defp display_name(username, _) do
    username
  end

  @doc """
  Creates a query that orders users by name.
  """
  def ordered(query) do
    from u in query,
      order_by: u.name
  end

  @doc """
  Returns a query that gets all users whose active flag matches the passed in value.
  """
  def active(query, active) do
    from u in query,
      where: u.active == ^active
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
