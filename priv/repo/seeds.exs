# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Nermesterts.Repo.insert!(%Nermesterts.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Nermesterts.Game
alias Nermesterts.Phrase

Nermesterts.Repo.delete_all(Game)
Nermesterts.Repo.delete_all(Phrase)

Nermesterts.Repo.insert!(%Game{name: "BANG!", min_players: 4, max_players: 7})
Nermesterts.Repo.insert!(%Game{name: "Betrayal at House on the Hill", min_players: 3, max_players: 6})
Nermesterts.Repo.insert!(%Game{name: "Boss Monster", min_players: 2, max_players: 4})
Nermesterts.Repo.insert!(%Game{name: "Codenames", min_players: 2, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Exploding Kittens", min_players: 2, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Hunters of Arcfall", min_players: 2, max_players: 6})
Nermesterts.Repo.insert!(%Game{name: "IncrediBrawl", min_players: 2, max_players: 4})
Nermesterts.Repo.insert!(%Game{name: "Love Letter", min_players: 2, max_players: 4})
Nermesterts.Repo.insert!(%Game{name: "Mascarade", min_players: 2, max_players: 13})
Nermesterts.Repo.insert!(%Game{name: "One Night Ultimate Werewolf", min_players: 3, max_players: 10})
Nermesterts.Repo.insert!(%Game{name: "Saboteur", min_players: 3, max_players: 10})
Nermesterts.Repo.insert!(%Game{name: "Salem", min_players: 4, max_players: 12})
Nermesterts.Repo.insert!(%Game{name: "Samurai Sword", min_players: 3, max_players: 7})
Nermesterts.Repo.insert!(%Game{name: "Secret Hitler", min_players: 5, max_players: 10})
Nermesterts.Repo.insert!(%Game{name: "Shadow Hunters", min_players: 4, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Small World", min_players: 2, max_players: 5})
Nermesterts.Repo.insert!(%Game{name: "Spyfall", min_players: 3, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Sushi Go!", min_players: 2, max_players: 5})
Nermesterts.Repo.insert!(%Game{name: "The Resistance", min_players: 5, max_players: 10})
Nermesterts.Repo.insert!(%Game{name: "The Resistance: Avalon", min_players: 5, max_players: 10})
Nermesterts.Repo.insert!(%Game{name: "Till Dawn", min_players: 4, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Tsuro", min_players: 2, max_players: 8})
Nermesterts.Repo.insert!(%Game{name: "Zombie Dice", min_players: 2, max_players: 99})

Nermesterts.Repo.insert!(%Phrase{message: "The King has decreed that you play #GAME# or face the penalty of death!", has_token: true})
Nermesterts.Repo.insert!(%Phrase{message: "You think you see a game off in the distance, but as you approach you realize it was just a mirage.", has_token: false})
