class AddDeliveryToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery, :boolean
  end
end
