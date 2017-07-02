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
    String.replace(message, "#GAME#", "<h3><img class='game-thumb' src='" <> image <> "'/>&nbsp;" <> name <> "</h3>")
  end
  def selected_game_phrase(%Phrase{message: _, has_token: true}, _) do
    ""
  end
  def selected_game_phrase(phrase, _) do
    selected_game_phrase(phrase)
  end

  def selected_game_phrase(%Phrase{message: message, has_token: false}), do: message
  def selected_game_phrase(_), do: ""
end
