defmodule Database.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :varchar
      add :logo, :varchar
      add :url, :varchar
    end

    alter table(:users) do
      add :company_id, references(:companies, type: :uuid)
    end
  end
end
