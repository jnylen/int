defmodule Database do
  @moduledoc """
  Database keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Database.Repo
  alias Database.{Ad, Company, Tag, User}

  import Ecto.Query, only: [from: 2]

  ############################# User

  @doc """
  Get an user by the id
  """
  def get_user(id), do: Repo.get(Database.User, id) |> Repo.preload([:company])

  @doc """
  Get an user by an email
  """
  def get_user_by_email(email) do
    Repo.one(
      from(u in User,
        where: ^email == u.email
      )
    )
  end

  @doc """
  Create an user
  """
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a company
  """
  def create_company(attrs) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a ad
  """
  def create_ad(attrs) do
    %Ad{}
    |> Ad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a tag
  """
  def create_tag(attrs) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end
end
