defmodule Website.StartController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html", header: "_header.html")
  end
end
