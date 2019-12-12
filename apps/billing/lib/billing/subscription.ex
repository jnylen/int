defmodule Billing.Subscription do
  @moduledoc """
  Subscription handling
  """

  @doc """
  Creates an subscription
  """
  def create(%{stripe_customer_id: nil, stripe_subscription_id: _} = _user),
    do: {:error, "No Stripe Customer ID"}

  def create(%{stripe_customer_id: customer_id, stripe_subscription_id: nil} = user) do
  end

  def create(%{stripe_customer_id: _, stripe_subscription_id: _} = _user),
    do: {:error, "Already has a Stripe Subscription ID"}

  @doc """
  Cancels an active subscription
  """
  def cancel(%{stripe_customer_id: nil, stripe_subscription_id: _} = _user),
    do: {:error, "No Stripe Customer ID"}

  def cancel(%{stripe_customer_id: _, stripe_subscription_id: nil} = _user),
    do: {:error, "No Stripe Subscription ID"}

  def cancel(%{stripe_customer_id: customer_id, stripe_subscription_id: subscription_id} = user) do
  end

  @doc """
  Tags the subscription as renewed
  """
  def renew(%{stripe_customer_id: nil, stripe_subscription_id: _} = _user),
    do: {:error, "No Stripe Customer ID"}

  def renew(%{stripe_customer_id: _, stripe_subscription_id: nil} = _user),
    do: {:error, "No Stripe Subscription ID"}

  def renew(%{stripe_customer_id: customer_id, stripe_subscription_id: subscription_id} = user) do
  end
end
