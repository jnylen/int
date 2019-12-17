defmodule Database.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "tags" do
    field(:name, :string)
    field(:bg_color, :string)
    field(:text_color, :string)

    # timestamps()
  end

  def changeset(tag, params \\ %{}) do
    tag
    |> cast(params, [:name, :bg_color, :text_color])
  end
end
