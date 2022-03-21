# frozen_string_literal: true

class CreateApiRefundOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :refund_order_items do |t|
      t.references :refund, null: false, foreign_key: true
      t.references :order_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
