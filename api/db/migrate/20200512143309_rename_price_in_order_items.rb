class RenamePriceInOrderItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :order_items, :price, :amount
  end
end
