defmodule Database.Company do
  use Database.Schema
  import Ecto.Changeset

  schema "companies" do
    field(:name, :string)
    field(:logo, :string)
    field(:url, :string)

    # timestamps()
  end

  def changeset(company, params \\ %{}) do
    company
    |> cast(params, [:name, :logo, :url])
    |> validate_format(:logo, ~r/^http(s|):\/\//)
    |> validate_format(:url, ~r/^http(s|):\/\//)
  end
end
