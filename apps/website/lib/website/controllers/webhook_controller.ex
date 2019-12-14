defmodule Website.WebhookController do
  use Website, :controller
  alias Stripe.Webhook

  @doc """
  This is the webhook controller for Stripe.

  It marks invoices as paid when it gets called by Stripe.
  """
  def stripe(conn, _params),
    do:
      conn.assigns.event.type
      |> stripe_event(conn.assigns.event.data, conn)

  # Payment succeeded
  defp stripe_event("charge.succeeded", data, conn) do
    {:ok, invoice} = Billing.Webhook.incoming("payment", data)

    invoice
    |> render_success(conn)
  end

  # Default to OK if no type match
  defp stripe_event(_, _, conn), do: render(conn, "success.json")

  # Render success/bad request
  defp render_bad_request(conn, reason) do
    conn
    |> render("400.json", reason: reason)
  end

  defp render_success({:error, reason}, conn), do: render_bad_request(conn, reason: reason)

  defp render_success(invoice, conn) do
    render(conn, "success.json", invoice: invoice)
  end
end
