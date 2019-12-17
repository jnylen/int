defmodule Database.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "companies" do
    field(:name, :string)
    field(:logo, :string)
    field(:url, :string)

    # timestamps()
  end

  def changeset(company, params \\ %{}) do
    company
    |> cast(params, [:name, :logo, :url])
    |> validate_format(:website, ~r/^http(s|):\/\//)
  end
end
