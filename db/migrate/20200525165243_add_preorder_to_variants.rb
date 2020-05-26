class AddPreorderToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :preorder, :integer, default: 0
    add_column :variants, :preordered, :integer, default: 0
  end
end
