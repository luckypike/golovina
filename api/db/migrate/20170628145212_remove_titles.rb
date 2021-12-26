class RemoveTitles < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :title, :string
    remove_column :kits, :title, :string
  end
end
