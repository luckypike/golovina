class AddSaleAndNewToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :sale, :boolean, default: false
    add_column :products, :latest, :boolean, default: false
  end
end
