defmodule Website.Router do
  use Website, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Website.Plugs.SetCurrentUser
  end

  pipeline :needs_to_be_authed do
    plug Website.Plugs.AuthenicateUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth_layout do
    plug :put_layout, {Website.LayoutView, "auth.html"}
  end

  scope "/", Website do
    pipe_through :browser

    get "/", StartController, :index
    get "/about", AboutController, :index
    get "/company", AboutController, :company
    get "/item", ItemController, :index
    get "/item/new", ItemController, :new
    get "/item/:id", ItemController, :show
  end

  scope "/auth", Website do
    pipe_through [:browser, :auth_layout]

    get "/logout", AuthController, :logout
    get "/login", AuthController, :login
    get "/signup", AuthController, :signup
    post "/identity/callback", AuthController, :callback
  end

  scope "/webhook", Website, as: :webhook do
    pipe_through [:api]
    post "/stripe", WebhookController, :stripe, as: :stripe
  end
end
