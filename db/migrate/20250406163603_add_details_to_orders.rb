class AddDetailsToOrders < ActiveRecord::Migration[7.2]
  def change

    add_reference :orders, :province, null: false, foreign_key: true




  end
end
