defmodule Website.Router do
  use Website, :router

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

  pipeline :auth_layout do
    plug :put_layout, {WebsiteWeb.LayoutView, "auth.html"}
  end

  scope "/", Website do
    pipe_through :browser

    get "/", StartController, :index
    get "/about", AboutController, :index
    get "/company", AboutController, :company
    get "/item", ItemController, :index
  end

  scope "/auth", Website do
    pipe_through [:browser, :auth_layout]

    # should be #DELETE
    # get "/logout", AuthController, :delete
    # get "/login", AuthController, :login
    # get "/signup", AuthController, :signup
    # get "/forget_password", AuthController, :forget_password
    # post "/forget_password", AuthController, :forget_password
    # post "/identity/callback", AuthController, :callback

    # get "/:provider/callback", AuthController, :callback
    # post "/:provider/callback", AuthController, :callback
    # get "/:provider/request", AuthController, :request
  end
end
