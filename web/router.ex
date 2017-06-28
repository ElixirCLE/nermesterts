defmodule Nermesterts.Router do
  use Nermesterts.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :edit_authenticate do
    plug Nermesterts.Plug.EditAuthenticate
  end

  pipeline :view_authenticate do
    plug Nermesterts.Plug.ViewAuthenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nermesterts do
    pipe_through :browser

    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/login", SessionController, only: [:new, :create]
  end

  scope "/", Nermesterts do
    pipe_through [:browser, :view_authenticate]

    get "/", PageController, :index
    get "/games", GameController, :index
    get "/phrases", PhraseController, :index
  end

  scope "/", Nermesterts do
    pipe_through [:browser, :edit_authenticate] # Use the default browser stack

    post "/", PageController, :post

    delete "/logout", SessionController, :delete

    resources "/user", UserController, only: [:edit, :update, :delete]

    post "/players/guest", PlayerController, :add_guest, as: :add_guest
    put "/players/deactivate", PlayerController, :deactivate_all, as: :player_deactivate_all
    resources "/players", PlayerController, except: [:new, :create, :show] do
      put "/activate", PlayerController, :activate, as: :activate
      put "/deactivate", PlayerController, :deactivate, as: :deactivate
    end

    get "/games/search", GameController, :search, as: :game_search
    resources "/games", GameController, except: [:edit, :index, :update]
    resources "/phrases", PhraseController, except: [:index]
  end

  # Other scopes may use custom stacks.
  scope "/api", Nermesterts do
    pipe_through :api

    get "/game", PageController, :index
  end
end
