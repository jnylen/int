defmodule Database.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field(:type, Database.TypeEnum)
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)

    belongs_to(:company, Database.Company)

    # timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:type, :name, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
