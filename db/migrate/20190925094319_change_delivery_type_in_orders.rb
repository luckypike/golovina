class ChangeDeliveryTypeInOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :delivery, 'integer USING CAST(delivery AS integer)'
  end
end
