class AddAmountsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :amount, :decimal
    add_column :orders, :amount_delivery, :decimal
  end
end
