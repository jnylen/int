defmodule Website.ItemController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Praktikplatser - int")
  end
end
