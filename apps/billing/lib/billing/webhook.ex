defmodule Billing.Webhook do
  @moduledoc """
  Handles incoming webhooks from Stripe on payments etc
  """

  @doc """
  Incoming webhooks
  """
  def incoming("payment", %{} = payment) do
    payment
    |> IO.inspect()
  end
end
