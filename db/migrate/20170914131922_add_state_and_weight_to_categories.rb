class AddStateAndWeightToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :state, :integer, default: 0
    add_column :categories, :weight, :integer, default: 0

    Category.update_all(state: :active)
  end
end
