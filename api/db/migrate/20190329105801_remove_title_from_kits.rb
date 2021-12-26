class RemoveTitleFromKits < ActiveRecord::Migration[5.2]
  def change
    remove_column :kits, :title, :string
  end
end
