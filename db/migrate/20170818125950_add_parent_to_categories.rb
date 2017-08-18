class AddParentToCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :parent_category
  end
end
