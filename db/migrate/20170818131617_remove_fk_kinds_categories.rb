class RemoveFkKindsCategories < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :kinds, :categories
    remove_foreign_key :products, :kinds
  end
end
