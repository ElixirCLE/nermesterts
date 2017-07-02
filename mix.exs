defmodule Nermesterts.Mixfile do
  use Mix.Project

  def project do
    [app: :nermesterts,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Nermesterts, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :ex_machina, :httpotion, :boardgamegeek_client,
                    :scout_apm]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:boardgamegeek_client, git: "https://github.com/ElixirCLE/boardgamegeek_client.git"},
     {:canada, "~> 1.0.1"},
     {:canary, "~> 1.1.0"},
     {:comeonin, "~> 1.0"},
     {:cowboy, "~> 1.0"},
     {:ex_machina, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:phoenix, "~> 1.2.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_pubsub, "~> 1.0"},
     {:postgrex, ">= 0.0.0"},
     {:scout_apm, "~> 0.0"},
     {:timex, "~> 3.0"},
     {:uuid, "~> 1.1"}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"],
     "s": ["phoenix.server"]]
  end
end
