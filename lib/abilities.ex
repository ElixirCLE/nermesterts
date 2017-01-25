defimpl Canada.Can, for: Nermesterts.User do
  alias Nermesterts.User

  def can?(%User{id: user_id}, action, %User{id: user_id})
    when action in [:edit, :update, :delete], do: true

  def can?(%User{}, _, _), do: false
end
