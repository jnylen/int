defmodule Billing.Customer do
  @moduledoc """
  Handles customers
  """

  @doc """
  Creates a customer in Stripe
  """
  def create(%{stripe_customer_id: nil} = user) do
  end

  def create(_), do: {:error, "Already has a Stripe Customer ID"}

  @doc """
  Updates a customer in Stripe
  """
  def update(%{stripe_customer_id: nil} = _user), do: {:error, "Has no Stripe Customer ID"}

  def update(%{stripe_customer_id: customer_id} = user) do
  end
end
