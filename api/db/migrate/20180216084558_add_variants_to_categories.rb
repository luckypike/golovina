class AddVariantsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :variants, :integer
  end
end
