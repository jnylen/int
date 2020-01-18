defmodule Database.User do
  use Database.Schema
  import Ecto.Changeset

  schema "users" do
    field(:type, Database.TypeEnum)
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)
    field(:stripe_customer_id, :string)
    field(:stripe_subscription_id, :string)

    belongs_to(:company, Database.Company, on_replace: :update)

    # timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [
      :type,
      :name,
      :email,
      :password,
      :company_id,
      :stripe_customer_id,
      :stripe_subscription_id
    ])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
