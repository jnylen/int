defmodule Website.AuthController do
  use Website, :controller

  plug Ueberauth
  alias Ueberauth.Strategy.Helpers

  @moduledoc """
  Auth specific calls
  """

  @doc """
  Login page
  """
  def login(conn, _params) do
    render(conn, "login.html",
      page_title: "Logga in - int",
      callback_url: Helpers.callback_url(conn, type: "login")
    )
  end

  @doc """
  Sign up page
  """
  def signup(conn, _params) do
    render(conn, "signup.html",
      changeset: conn,
      page_title: "Bli medlem - int",
      callback_url: Helpers.callback_url(conn, type: "signup")
    )
  end

  @doc """
  Sign up page for companies
  """
  def signup_company(conn, _params) do
    render(conn, "signup.company.html",
      changeset: conn,
      page_title: "Skapa företag - int",
      callback_url: Helpers.callback_url(conn, type: "signup_company")
    )
  end

  @doc """
  Log out
  """
  def logout(conn, _params),
    do:
      conn
      |> put_flash(:info, "Du har blivit utloggad!")
      |> configure_session(drop: true)
      |> redirect(to: "/")

  @doc """
  Signs an user up
  """
  def callback(
        %{assigns: %{ueberauth_auth: auth}} = conn,
        %{"type" => "user_signup"} = _params
      ) do
    conn
    |> create_user(auth)
    |> redirect(to: "/")
  end

  def callback(
        %{assigns: %{ueberauth_auth: auth}} = conn,
        %{"type" => "company_signup"} = _params
      ) do
    # Skapa user
    # Skapa företag

    conn
    |> create_user(auth)
    |> create_company(auth)
    |> redirect(to: "/")
  end

  @doc """
  Signs an user in
  """
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"type" => "login"} = _params) do
    conn
    |> authenticated(Website.User.authenticate(auth))
  end

  @doc """
  Ueberauth failed
  """

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  defp create_user(conn, auth, type \\ "student") do
    case Website.User.create_user(auth, type) do
      {:error, _error} ->
        conn
        |> put_flash(:error, "ERROR!")

      {:ok, user} ->
        conn
        |> put_flash(:info, "Du har blivit registrerad och inloggad!")
        |> put_session(:current_user_id, user.id)
    end
  end

  defp create_company(conn, auth) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    case Website.User.create_company(auth) do
      {:error, _error} ->
        conn
        |> put_flash(:error, "ERROR!")

      {:ok, company} ->
        user = Database.get_user(user_id)
        # {:ok, company_id} = company.id

        {:ok, _} =
          user
          |> Database.User.changeset(%{
            company_id: company.id
          })
          |> Database.Repo.update()

        conn
    end
  end

  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Du är nu inloggad!")
    |> put_session(:current_user_id, user.id)
    |> redirect(to: "/")
  end

  defp authenticated(conn, {:error, error}) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/auth/login")
  end
end
