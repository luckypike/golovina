class AddPayedAtToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payed_at, :datetime
  end
end
