class AddPinnedToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :pinned, :boolean, default: false
  end
end
