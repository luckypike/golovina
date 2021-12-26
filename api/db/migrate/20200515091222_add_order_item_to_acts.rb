class AddOrderItemToActs < ActiveRecord::Migration[6.0]
  def change
    add_reference :acts, :order_item, foreign_key: true
  end
end
