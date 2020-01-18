defmodule Website.AboutController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html", header: "_header.html", page_title: "Om oss - int")
  end

  def company(conn, _params) do
    render(conn, "company.html", header: "_header.html", page_title: "Företag - int")
  end
end
