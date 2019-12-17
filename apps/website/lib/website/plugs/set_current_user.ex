defmodule Website.Plugs.SetCurrentUser do
  import Plug.Conn

  @moduledoc """
  Grab the user based on the current user id if logged in
  """

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    cond do
      current_user = user_id && Database.get_user(user_id) ->
        conn
        |> assign(:current_user, current_user)
        |> assign(:authed?, true)

      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:authed?, false)
    end
  end
end
