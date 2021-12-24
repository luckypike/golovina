class AddPaymentFieldsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_id, :string
    add_column :orders, :payment_amount, :decimal
  end
end
