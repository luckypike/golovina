class AddVariantToThemable < ActiveRecord::Migration[6.0]
  def change
    add_reference :themables, :variant, null: false, foreign_key: true
    add_column :themables, :weight, :integer, default: 0
    remove_reference :themables, :product, foreign_key: true
  end
end
