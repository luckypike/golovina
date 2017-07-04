class AddCategoryToVariants < ActiveRecord::Migration[5.1]
  def change
    add_reference :variants, :category, foreign_key: true
  end
end
