class AddPriceLastToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price_last, :decimal
  end
end
