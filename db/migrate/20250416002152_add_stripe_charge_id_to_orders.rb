class AddStripeChargeIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :stripe_charge_id, :string
  end
end
