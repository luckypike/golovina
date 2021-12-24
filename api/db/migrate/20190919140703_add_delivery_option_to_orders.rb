class AddDeliveryOptionToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delivery_option, :integer
  end
end
