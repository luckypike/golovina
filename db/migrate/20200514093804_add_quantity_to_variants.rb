class AddQuantityToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :quantity, :integer, null: false, default: 0
  end
end
