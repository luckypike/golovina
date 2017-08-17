class AddTitleToKits < ActiveRecord::Migration[5.1]
  def change
    add_column :kits, :title, :string
  end
end
