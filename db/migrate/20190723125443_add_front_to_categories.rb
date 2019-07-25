class AddFrontToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :front, :boolean
  end
end
