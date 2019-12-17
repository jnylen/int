defmodule Website.Helper do
  @moduledoc """
  Bunch of helpers for the website app
  """

  @type email :: String.t()
  @type url :: String.t()

  @type image_options :: list(image_option_item)
  @type image_option_item ::
          {size_key, size_value} | {default_key, default_value} | {rating_key, rating_value}
  @type size_key :: :s | :size
  @type size_value :: 1..2048
  @type default_key :: :d | :default
  @type default_value :: :"404" | :mm | :identicon | :monsterid | :wavatar | :retro | :blank | url
  @type rating_key :: :r | :rating
  @type rating_value :: :g | :pg | :r | :x

  @spec md5(String.t()) :: String.t()
  defp md5(str) do
    str
    |> (fn s -> :erlang.md5(s) end).()
    |> Base.encode16(case: :lower)
  end

  @doc """
  Create a gravatar url from email
  """
  @spec gravatar(email, image_options) :: url
  def gravatar(email, opts \\ []) do
    # Hash the email
    hash =
      email
      |> String.trim()
      |> String.downcase()
      |> md5

    # Build params with opts
    params = "?#{URI.encode_query(opts)}"
    nonempty_params? = String.length(params) > 1

    # Return a url
    "https://www.gravatar.com/avatar/#{hash}#{if nonempty_params?, do: params}"
  end
end
