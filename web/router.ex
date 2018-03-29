defmodule Bandstock.Router do
  use Bandstock.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug Bandstock.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Bandstock do
    pipe_through :browser # Use the default browser stack

    get "/", SheetController, :main

    get "/cards/new", CardController, :new        #show new card form
    post "/cards/new", CardController, :create    #post the new card
    get "/cards", CardController, :index          #list all cards
    get "/cards/:id", CardController, :show       #show one card by :id
    get "/image/:id", CardController, :image      #show just the card image


    get "/sheets/new", SheetController, :new        #show new sheet form
    post "/sheets/new", SheetController, :create    #post the new sheet
    get "/sheets", SheetController, :index          #list all sheets
    get "/sheets/:id", SheetController, :show       #show one sheet by :id
  end

  scope "/auth", Bandstock do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request #ueberauth looks at :provider to determine strategy.  Handles OUTGOING request
    get "/:provider/callback", AuthController, :callback #when user is sent back from provider. Handles INCOMING request
  end

  # Other scopes may use custom stacks.
  # scope "/api", Bandstock do
  #   pipe_through :api
  # end
end
