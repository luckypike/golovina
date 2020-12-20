class AddCertToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :cert, null: true, foreign_key: true
  end
end
