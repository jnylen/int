defmodule Website.AboutController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html", header: "_header.html")
  end

  def company(conn, _params) do
    render(conn, "index.html", header: "_header.html")
  end
end
