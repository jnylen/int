defmodule Billing.Subscription do
  def get(id) do
    Stripe.Subscription.retrieve(id)
  end
end
