defmodule Website.ItemController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Praktikplatser - int")
  end

  def show(conn, _params) do
    render(conn, "show.html", page_title: "Show item - int")
  end

  def new(conn, _params) do
    # TODO: Make a check that it's actually a company account
    render(conn, "new.html", page_titlte: "New item - int", conn: conn)
  end

  def create(conn, params) do

  end
end
