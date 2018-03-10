defmodule Nermesterts.User do
  use Nermesterts.Web, :model

  alias Nermesterts.User

  @required_fields ~w(username)a
  @optional_fields ~w(active admin guest name password password_confirmation)a
  @all_fields @required_fields ++ @optional_fields

  @required_registration_fields ~w(username password password_confirmation)a
  @all_registration_fields @required_registration_fields ++ @optional_fields

  @guest_creation_fields ~w(crypted_password)a ++ @all_fields

  schema "users" do
    field :username, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :name, :string
    field :active, :boolean, default: false
    field :guest, :boolean, default: false
    field :admin, :boolean, default: false

    many_to_many :games, Nermesterts.Game, join_through: "user_games",
      join_keys: [user_id: :id, game_id: :bgg_id], unique: true,
      on_replace: :delete

    timestamps()
  end

  def guest_changeset() do
    uuid = UUID.uuid4(:hex)
    guest_value = "guest-#{uuid}"
    params = %{name: "Guest", username: String.slice(guest_value, 0..19),
      crypted_password: guest_value, active: true, guest: true}
    cast(%User{}, params, @guest_creation_fields)
  end

  def registration_changeset(struct, params) do
    struct
    |> cast(params, @all_registration_fields)
    |> validate_required(@required_registration_fields)
    |> common_changeset
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> common_changeset
  end

  defp common_changeset(changeset) do
    changeset
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint(:username, downcase: true)
    |> unique_constraint(:unique_user_games_index)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> put_encrypted_pass
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
      where: u.active == ^active and u.guest == false
  end

  @doc """
  Returns a query that gets all guest users
  """
  def guest(query) do
    from u in query,
      where: u.guest == true
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
