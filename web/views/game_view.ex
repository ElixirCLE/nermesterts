defmodule Nermesterts.GameView do
  use Nermesterts.Web, :view

  def render("games_search.json", %{results: results}) do
    %{results: results}
  end

  def render("games_info.json", %{result: result}) do
    %{results: result}
  end
end
