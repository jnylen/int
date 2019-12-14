defmodule Database.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :varchar
      add :type, Database.TypeEnum.type()
      add :email, :varchar
      add :password, :varchar
    end
  end
end
