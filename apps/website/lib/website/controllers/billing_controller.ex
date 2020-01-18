defmodule Website.BillingController do
  use Website, :controller

  def index(conn, _params) do
    if is_nil(conn.assigns.current_user.stripe_subscription_id) do
      {:ok, checkout_session} = Billing.Checkout.create(conn.assigns.current_user)

      render(conn, "index.html",
        header: "_header.html",
        page_title: "Prenumation - int",
        checkout_session: checkout_session
      )
    else
      conn
      |> redirect(to: "/")
    end
  end

  def success(conn, params) do
    # Get session
    {:ok,
     %Stripe.Session{customer: customer_id, customer_email: email, subscription: subscription}} =
      params["session_id"]
      |> Billing.Checkout.get()

    # Get the user from the session id
    user = Database.get_user_by_email(email)

    # Get the subscription
    {:ok, %Stripe.Subscription{status: "active"}} =
      subscription
      |> Billing.Subscription.get()

    # Update user
    {:ok, _user} =
      user
      |> Database.User.changeset(%{
        stripe_customer_id: customer_id,
        stripe_subscription_id: subscription
      })
      |> Database.Repo.update()

    conn
    |> redirect(to: "/")
  end

  def cancel(conn, _params) do
    conn
    |> redirect(to: "/")
  end
end
