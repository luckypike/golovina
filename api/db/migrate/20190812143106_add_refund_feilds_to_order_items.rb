class AddRefundFeildsToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :refund_id, :integer
    add_column :order_items, :repayment, :boolean, default: false
  end
end
