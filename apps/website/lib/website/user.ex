defmodule Website.User do
  alias Ueberauth.Auth

  @moduledoc """
  Manages the user related stuff in the website app.
  """

  @doc """
  Creates an user
  """
  def create_user(
        %Auth{extra: %{raw_info: raw_info}, provider: :identity} = auth,
        type \\ "student"
      ) do
    case Database.get_user_by_email(auth.uid) do
      nil ->
        case validate_pass(raw_info) do
          {:error, error} ->
            {:error, error}

          {:ok, _} ->
            Database.create_user(%{
              type: type,
              name: raw_info["name"],
              email: raw_info["email"],
              password: Comeonin.Bcrypt.hashpwsalt(raw_info["password"])
            })
        end

      _ ->
        {:error, "User already exists"}
    end
  end

  @doc """
  Creates a company
  """
  def create_company(%Auth{extra: %{raw_info: raw_info}, provider: :identity} = _auth) do
    Database.create_company(%{
      name: raw_info["company_name"],
      logo: raw_info["logo"],
      url: raw_info["url"]
    })
  end

  @doc """
  Authenticates an user
  """
  def authenticate(%Auth{provider: :identity} = auth) do
    if is_nil(auth.uid) || String.trim(auth.uid) == "" do
      {:error, "Ingen email inskriven."}
    else
      Database.get_user_by_email(auth.uid)
      |> authorize(auth)
      |> info_from_database
    end
  end

  defp authorize(nil, _auth), do: {:error, "Felaktig användarnamn eller lösenord."}

  defp authorize(user, auth) do
    if is_nil(auth.credentials.other.password) ||
         String.trim(auth.credentials.other.password) == "" do
      {:error, "Inget lösenord givet."}
    else
      Comeonin.Bcrypt.checkpw(auth.credentials.other.password, user.password)
      |> resolve_authorization(user)
    end
  end

  defp resolve_authorization(false, _user), do: {:error, "Invalid username or password"}
  defp resolve_authorization(true, user), do: {:ok, info_from_database(user)}

  @doc """
    Validate that the passwords actually match
  """
  def validate_pass(
        %{"contact_person.password" => pw, "contact_person.password_confirmation" => pw} =
          _auth_params
      ),
      do: {:ok, "both the same"}

  def validate_pass(%{"password" => pw, "password_confirmation" => pw} = _auth_params),
    do: {:ok, "both the same"}

  def validate_pass(_), do: {:error, "the passwords must match"}

  defp info_from_database({:error, error}), do: {:error, error}

  defp info_from_database(user) do
    user
  end
end
