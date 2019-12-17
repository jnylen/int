defmodule Website.Plugs.AuthenicateUser do
  import Plug.Conn
  alias Website.Router.Helpers

  @moduledoc """
  This module makes sure the user is logged in
  """

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(external: Helpers.auth_url(Website.Endpoint, :login))
      |> halt()
    end
  end
end
