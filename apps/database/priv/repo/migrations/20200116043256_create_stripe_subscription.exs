defmodule Database.Repo.Migrations.CreateStripeSubscription do
  use Ecto.Migration

  def change do
    alter table("users") do
      add(:stripe_customer_id, :string)
      add(:stripe_subscription_id, :string)
    end
  end
end
