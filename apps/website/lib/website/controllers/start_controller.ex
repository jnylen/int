defmodule Website.StartController do
  use Website, :controller
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    items =
      from(Database.Ad,
        order_by: fragment("RANDOM()"),
        limit: 3
      )
      |> Database.Repo.all()
      |> Database.Repo.preload([:tag, {:contact_person, :company}])

    render(conn, "index.html", header: "_header.html", items: items)
  end
end
