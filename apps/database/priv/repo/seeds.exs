# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Database.Repo.insert!(%Database.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Tags
[
  %{name: "webutveckling", bg_color: "red", text_color: "red"},
  %{name: "marketing", bg_color: "blue", text_color: "blue"},
  %{name: "analytics", bg_color: "yellow", text_color: "yellow"}
]
|> Enum.map(fn tag ->
  tag
  |> Database.create_tag()
end)
