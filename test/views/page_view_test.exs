defmodule Nermesterts.PageViewTest do
  use Nermesterts.ConnCase, async: true

  alias Nermesterts.PageView
  alias Nermesterts.Phrase
  alias Nermesterts.Game

  @phrase_no_token %Phrase{message: "Name of the game", has_token: false}
  @phrase_with_token %Phrase{message: "Name of the #GAME#", has_token: true}
  @valid_game %Game{name: "bloopers", image: "url"}

  test "nil phrase with no game provided" do
    assert PageView.selected_game_phrase(nil) == ""
  end

  test "existing phrase without token or game" do
    assert PageView.selected_game_phrase(@phrase_no_token) == "Name of the game"
  end

  test "existing phrase with token and game" do
    assert PageView.selected_game_phrase(@phrase_with_token, @valid_game) ==
      "Name of the <h3><img class='game-thumb' src='url'/>&nbsp;bloopers</h3>"
  end

  test "existing phrase with token and nil game" do
    assert PageView.selected_game_phrase(@phrase_with_token, nil) == ""
  end

  test "existing phrase with no token but with game" do
    assert PageView.selected_game_phrase(@phrase_no_token, @valid_game) == "Name of the game"
  end
end
