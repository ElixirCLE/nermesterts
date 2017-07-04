defmodule Nermesterts.PageView do
  use Nermesterts.Web, :view

  alias Nermesterts.{Game, Phrase}

  def render("index.json", %{game: game, num_players: players, active_players: _, inactive_players: _, phrase: _}) do
    %{
      game: game.name,
      num_players: players
    }
  end

  def selected_game_phrase(%Phrase{message: message, has_token: true}, %Game{name: name, image: image}) do
    String.replace(message, "#GAME#", phrase_markup(name, image))
  end
  def selected_game_phrase(%Phrase{message: _, has_token: true}, _) do
    ""
  end
  def selected_game_phrase(phrase, _) do
    selected_game_phrase(phrase)
  end

  def selected_game_phrase(%Phrase{message: message, has_token: false}), do: message
  def selected_game_phrase(_), do: ""

  defp phrase_markup(name, image) do
    "<h3>" <> thumbnail_markup(image) <> name <> "</h3>"
  end

  defp thumbnail_markup(nil), do: ""
  defp thumbnail_markup(image) do
    "<img class='game-thumb' src='" <> image <> "'/>&nbsp;"
  end
end
