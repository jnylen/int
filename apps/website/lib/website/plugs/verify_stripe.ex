defmodule Website.Plugs.VerifyStripe do
  @behaviour Plug

  require Logger

  import Plug.Conn
  import Website.Router.Helpers

  @secret Application.get_env(:stripity_stripe, :webhook_secret)

  def init(opts), do: opts

  def call(%{request_path: request_path} = conn, _opts) do
    webhook_path = webhook_stripe_path(conn, :stripe)

    case request_path do
      ^webhook_path -> verify_req(conn)
      _ -> conn
    end
  end

  defp verify_req(conn) do
    case read_body(conn) do
      {:ok, body, conn} -> do_verify(conn, body)
      {:more, _, conn} -> {:error, :too_large, conn}
    end
  end

  defp do_verify(conn, body) do
    [signature] = get_req_header(conn, "stripe-signature")

    case Stripe.Webhook.construct_event(body, signature, @secret) do
      {:ok, %Stripe.Event{} = event} ->
        conn
        |> assign(:event, event)

      {:error, err} ->
        Logger.error("error verifying stripe event reason: #{err}")

        conn
        |> send_resp(:bad_request, "Webhook Not Verified")
        |> halt()
    end
  end
end
