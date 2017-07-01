// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"


// Required for Bootstrap dropdowns to work
import $ from "jquery"
global.jQuery = require("jquery")
global.bootstrap = require("bootstrap")
global.select2 = require("select2")

// Allows delete links to work in Bootstrap dropdowns
$(document).off('click.bs.dropdown.data-api', '.dropdown form');

global.gameSelector = new function() {
  this.init = function() {
    $('#game_select').select2({
      theme: 'bootstrap',
      ajax: {
        url: "/games/search",
        dataType: 'json',
        delay: 500,
        data: function(params) {
          return {
            q: params.term, // search term
          };
        },
        processResults: function(data, params) {
          return {
            results: data.results,
            pagination: {
              more: false
            }
          };
        },
        cache: true
      },
      escapeMarkup: function (markup) { return markup; },
      minimumInputLength: 1,
      templateResult: formatGame,
      templateSelection: formatGameSelection
    });

    $('#game_select').on('select2:select', function(evt) {
      $.ajax({
        url: "/games/search",
        data: {
          id: $('#game_select').val()
        },
        success: function(data) {
          var result = data.results[0];
          $('#game_bgg_id').val(result.bgg_id);
          $('#game_name').val(result.name);
          $('#game_image').val(result.image);

          $('#game_min_players').val(result.min_players);
          $('#game_max_players').val(result.max_players);
          $('#game_image_holder').attr('src', result.image);

          $('#image-section').removeClass('display-none');
        }
      });
    });

    function formatGame(game) {
      if (game.loading) {
        return game.text;
      }

      return "<div class='select2-result-game clearfix'>" +
               "<span class='select2-result-game-image'><img class='game-thumb' src='" + game.image + "'/></span>&nbsp;" +
               "<span class='select2-result-game-meta inline-block'>" +
                 "<div class='select2-result-game-title'>" + game.name + "</div>" +
               "</span>"+
             "</div>";
    };

    function formatGameSelection(game) {
      return game.name || game.text;
    }
  };
};
