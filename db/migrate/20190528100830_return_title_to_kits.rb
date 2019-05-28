class ReturnTitleToKits < ActiveRecord::Migration[5.2]
  def change
    add_column :kits, :title, :string
  end
end
