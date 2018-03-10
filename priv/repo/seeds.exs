# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Repo.insert!(%Nermesterts.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Nermesterts.Game
alias Nermesterts.Phrase
alias Nermesterts.Repo
alias Nermesterts.User

Repo.delete_all(Game)
Repo.delete_all(Phrase)
Repo.delete_all(User)

user = Repo.insert!(%User{username: "admin", crypted_password: Comeonin.Bcrypt.hashpwsalt("changeme!"), active: true, admin: true}) |> Repo.preload(:games)

Repo.insert!(%Game{name: "BANG!", min_players: 4, max_players: 7, bgg_id: 3955})
Repo.insert!(%Game{name: "Betrayal at House on the Hill", min_players: 3, max_players: 6, bgg_id: 10547})
Repo.insert!(%Game{name: "Boss Monster", min_players: 2, max_players: 4, bgg_id: 131835})
Repo.insert!(%Game{name: "Codenames", min_players: 2, max_players: 8, bgg_id: 178900})
Repo.insert!(%Game{name: "Exploding Kittens", min_players: 2, max_players: 8, bgg_id: 172225})
Repo.insert!(%Game{name: "Hunters of Arcfall", min_players: 2, max_players: 6, bgg_id: 142988})
Repo.insert!(%Game{name: "IncrediBrawl", min_players: 2, max_players: 4, bgg_id: 142653})
Repo.insert!(%Game{name: "Love Letter", min_players: 2, max_players: 4, bgg_id: 129622})
Repo.insert!(%Game{name: "Mascarade", min_players: 2, max_players: 13, bgg_id: 139030})
Repo.insert!(%Game{name: "One Night Ultimate Werewolf", min_players: 3, max_players: 10, bgg_id: 147949})
Repo.insert!(%Game{name: "Saboteur", min_players: 3, max_players: 10, bgg_id: 9220})
Repo.insert!(%Game{name: "Salem 1692", min_players: 4, max_players: 12, bgg_id: 175549})
Repo.insert!(%Game{name: "Samurai Sword", min_players: 3, max_players: 7, bgg_id: 128667})
Repo.insert!(%Game{name: "Secret Hitler", min_players: 5, max_players: 10, bgg_id: 188834})
Repo.insert!(%Game{name: "Shadow Hunters", min_players: 4, max_players: 8, bgg_id: 24068})
Repo.insert!(%Game{name: "Small World", min_players: 2, max_players: 5, bgg_id: 40692})
Repo.insert!(%Game{name: "Spyfall", min_players: 3, max_players: 8, bgg_id: 166384})
Repo.insert!(%Game{name: "Sushi Go!", min_players: 2, max_players: 5, bgg_id: 133473})
Repo.insert!(%Game{name: "The Resistance", min_players: 5, max_players: 10, bgg_id: 41114})
Repo.insert!(%Game{name: "The Resistance: Avalon", min_players: 5, max_players: 10, bgg_id: 128882})
Repo.insert!(%Game{name: "Till Dawn", min_players: 4, max_players: 8, bgg_id: 154498})
Repo.insert!(%Game{name: "Tsuro", min_players: 2, max_players: 8, bgg_id: 16992})
Repo.insert!(%Game{name: "Zombie Dice", min_players: 2, max_players: 99, bgg_id: 62871})

Enum.each(Game |> Repo.all, fn(game) ->
  game
  |> Repo.preload(:users)
  |> Ecto.Changeset.change
  |> Ecto.Changeset.put_assoc(:users, [user])
  |> Repo.update
end)

Repo.insert!(%Phrase{message: "The King has decreed that you play #GAME# or face the penalty of death!", has_token: true})
Repo.insert!(%Phrase{message: "A shady figure approaches you. \"Psst. Hey, kid. Why don't you come check out #GAME#?\"", has_token: true})
Repo.insert!(%Phrase{message: "#GAME# is the kind of game you can take home to Mom.", has_token: true})
Repo.insert!(%Phrase{message: "You think you see a game off in the distance, but as you approach you realize it was just a mirage.", has_token: false})
Repo.insert!(%Phrase{message: "I walk this empty street / On the Boulevard of Broken Dreams / Where the city sleeps / And I'm the only one and I walk alone", has_token: false})
Repo.insert!(%Phrase{message: "My shadow's the only one that walks beside me / My shallow heart's the only thing that's beating / Sometimes I wish someone out there will find me / 'Til then I walk alone", has_token: false})
Repo.insert!(%Phrase{message: "After a day of adventuring, you come home to find that your home has been raided and all of your games are missing.", has_token: false})
