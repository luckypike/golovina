class RemoveCategoryFromVariants < ActiveRecord::Migration[5.2]
  def change
    remove_reference :variants, :category, foreign_key: true
  end
end
