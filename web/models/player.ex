defmodule Nermesterts.Player do
  use Nermesterts.Web, :model

  @required_fields ~w(username plain_password)
  @optional_fields ~w(name active)

  schema "players" do
    field :username, :string
    field :crypted_password, :string
    field :plain_password, :string, virtual: true
    field :name, :string
    field :active, :boolean, default: true

    timestamps()
  end

  def create(changeset, repo) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_length(:plain_password, min: 5)
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

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
