defmodule Nermesterts.GameView do
  use Nermesterts.Web, :view

  def render("games_search.json", %{results: results}) do
    %{results: results}
  end

  def render("games_info.json", %{result: result}) do
    %{results: result}
  end

  def generate_owner_popover(users) do
    opening = "<a class='help' rel='tooltip' data-html='true' data-original-title='<ul class=\"tooltip-inner\">"
    closing = "</ul>'>" <> "#{length(users)}" <> "</a>"

    opening <> generate_owner_list(users) <> closing
  end

  defp generate_owner_list([user|users]) do
    {:safe, safe_name} = sanitize(User.display_name(user), :strip_tags)
    {:safe, safe_name} = html_escape(safe_name)
    "<li>" <> safe_name <> "</li>" <> generate_owner_list(users)
  end
  defp generate_owner_list([]) do
    ""
  end
end
