class AddEmptyToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :empty, :boolean, default: false
  end
end
