class AddColorsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :colors, :string, array: true
    add_index :products, :colors, using: :gin
  end
end
