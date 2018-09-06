class AddFieldsToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :desc, :text
    add_column :variants, :price, :numeric
    add_column :variants, :price_last, :numeric
  end
end
