defmodule Website.ItemController do
  use Website, :controller

  def index(conn, _params) do
    render(conn, "index.html",
      items:
        Database.Repo.all(Database.Ad) |> Database.Repo.preload([:tag, {:contact_person, :company}]),
      page_title: "Praktikplatser - int"
    )
  end

  def show(conn, params) do
    render(conn, "show.html",
      item:
        Database.Repo.get(Database.Ad, params["id"])
        |> Database.Repo.preload([:tag, {:contact_person, :company}]),
      page_title: "Show item - int"
    )
  end

  def new(conn, _params) do
    # TODO: Make a check that it's actually a company account
    render(conn, "new.html",
      tags: Database.Repo.all(Database.Tag),
      page_title: "New item - int",
      conn: conn
    )
  end

  def create(conn, params) do
    params
    |> IO.inspect()

    {:ok, ad} =
      %{
        name: params["name"],
        location: params["location"],
        start: params["start"],
        length: params["length"],
        description: params["description"],
        tag_id: params["tag_id"],
        contact_person_id: conn.assigns.current_user.id,
        contact_name: params["contact_name"],
        contact_email: params["contact_email"],
        contact_phone: params["contact_phone"]
      }
      |> IO.inspect()
      |> Database.create_ad()
      |> IO.inspect()

    conn
    |> put_flash(:info, "Annons skapad!")
    |> redirect(to: "/item/#{ad.id}")
  end
end
