class AddNameToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :name, :string
  end
end
