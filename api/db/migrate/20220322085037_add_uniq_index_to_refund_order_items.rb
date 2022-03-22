# frozen_string_literal: true

class AddUniqIndexToRefundOrderItems < ActiveRecord::Migration[6.1]
  def change
    remove_index :refund_order_items, :order_item_id
    add_index :refund_order_items, :order_item_id, unique: true
  end
end
