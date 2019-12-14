defmodule Database.Repo.Migrations.CreateAds do
  use Ecto.Migration

  def change do
    create table(:ads, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :varchar
      add :location, :varchar
      add :start, :date
      add :length, :integer
      add :description, :text
      add :contact_person_id, references(:users, type: :uuid)
      add :contact_name, :varchar
      add :contact_email, :varchar
      add :contact_phone, :varchar
    end
  end
end
