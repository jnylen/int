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
    case Website.User.create_user(auth) do
      {:error, error} ->
        error |> IO.inspect()

        conn
        |> put_flash(:error, "ERROR!")
        |> redirect(to: "/")

      {:ok, user} ->
        conn
        |> put_flash(:info, "Du har blivit registrerad och inloggad!")
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")
    end
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
