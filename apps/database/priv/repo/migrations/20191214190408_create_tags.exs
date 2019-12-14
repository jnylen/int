defmodule Database.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :varchar
      add :bg_color, :varchar
      add :text_color, :varchar
    end

    alter table(:ads) do
      add :tag_id, references(:tags, type: :uuid)
    end
  end
end
