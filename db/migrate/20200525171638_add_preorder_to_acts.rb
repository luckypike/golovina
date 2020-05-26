class AddPreorderToActs < ActiveRecord::Migration[6.0]
  def change
    add_column :acts, :preorder, :boolean, default: false
  end
end
