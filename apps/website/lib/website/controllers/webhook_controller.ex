defmodule Website.WebhookController do
  use Website, :controller
  alias Stripe.Webhook

  @secret Application.get_env(:stripity_stripe, :webhook_secret)

  @doc """
  This is the webhook controller for Stripe.

  It marks invoices as paid when it gets called by Stripe.
  """
  def stripe(conn, _params) do
    case conn.assigns.event.type do
      # Money money money
      "invoice.payment_succeeded" ->
        {:ok, invoice} = Billing.Webhook.incoming("payment", conn.assigns.event.data)

        # Send email
        # invoice
        # |> Mailer.Invoice.paid_email()

        # Render success
        invoice
        |> render_success(conn)

      # Invoice email sent
      "invoice.sent" ->
        {:ok, invoice} = Billing.Webhook.incoming("sent", conn.assigns.event.data)

        # Render success
        invoice
        |> render_success(conn)

      # Payment failed. Notify CEO and lecturer
      "invoice.payment_failed" ->
        render(conn, "success.json")

      # Catch all
      _ ->
        render(conn, "success.json")
    end
  end

  defp render_bad_request(conn, reason) do
    conn
    |> render("400.json", reason: reason)
  end

  defp render_success(invoice, conn) do
    render(conn, "success.json", invoice: invoice)
  end

  defp render_success({:error, reason}, conn), do: render_bad_request(conn, reason: reason)
end
