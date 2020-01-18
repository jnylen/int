defmodule Billing.Checkout do
  def create(user) do
    Stripe.Session.create(%{
      locale: "sv",
      mode: "subscription",
      payment_method_types: ["card"],
      customer_email: user.email,
      subscription_data: %{
        items: [
          %{
            plan: "company"
          }
        ],
        metadata: %{
          user_id: user.id |> to_string()
        }
      },
      success_url: "http://localhost:4000/billing/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "http://localhost:4000/billing/cancel"
    })
  end

  def get(id) do
    Stripe.Session.retrieve(id)
  end
end
