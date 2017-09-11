class AddOutOfStockToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :out_of_stock, :boolean, default: false
  end
end
