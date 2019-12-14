defmodule Website.AuthController do
  use Website, :controller

  def login(conn, _params) do
    render(conn, "login.html", page_title: "Logga in - int")
  end

  def signup(conn, _params) do
    render(conn, "signup.html", page_title: "Bli medlem - int")
  end
end
