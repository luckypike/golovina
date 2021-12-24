class AddTrashToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :trash, :boolean, default: false
  end
end
