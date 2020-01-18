defmodule Database.Ad do
  use Database.Schema
  import Ecto.Changeset

  schema "ads" do
    field(:name, :string)
    field(:location, :string)
    field(:start, :date)
    field(:length, :integer)
    field(:description, :string)

    belongs_to(:contact_person, Database.User, on_replace: :update)
    belongs_to(:tag, Database.Tag, on_replace: :update)

    field(:contact_name, :string)
    field(:contact_email, :string)
    field(:contact_phone, :string)

    # timestamps()
  end

  def changeset(ad, params \\ %{}) do
    ad
    |> cast(params, [
      :name,
      :location,
      :start,
      :length,
      :description,
      :tag_id,
      :contact_person_id,
      :contact_name,
      :contact_email,
      :contact_phone
    ])
  end
end
