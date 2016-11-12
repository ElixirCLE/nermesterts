defmodule Nermesterts.Router do
  use Nermesterts.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Nermesterts do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :post

    resources "/registrations", RegistrationController, only: [:new, :create]

    resources "/login", SessionController, only: [:new, :create]
    delete "/logout", SessionController, :delete

    resources "/user", UserController, only: [:edit, :update, :delete]

    put "/players/deactivate", PlayerController, :deactivate_all, as: :player_deactivate_all
    resources "/players", PlayerController, except: [:new, :create, :show] do
      put "/activate", PlayerController, :activate, as: :activate
      put "/deactivate", PlayerController, :deactivate, as: :deactivate
    end

    resources "/games", GameController, except: [:edit, :update]
    resources "/phrases", PhraseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Nermesterts do
  #   pipe_through :api
  # end
end
