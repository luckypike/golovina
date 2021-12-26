class RemoveBooleanFieldsFromVariants < ActiveRecord::Migration[6.0]
  def change
    remove_column :variants, :last, :boolean
    remove_column :variants, :bestseller, :boolean
    remove_column :variants, :latest, :boolean
    remove_column :variants, :sale, :boolean
  end
end
