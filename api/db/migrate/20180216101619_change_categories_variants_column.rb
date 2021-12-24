class ChangeCategoriesVariantsColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :variants, :variants_counter
  end
end
