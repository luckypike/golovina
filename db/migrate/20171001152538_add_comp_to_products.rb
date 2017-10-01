class AddCompToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :comp, :text
  end
end
