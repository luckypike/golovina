class RemoveImagesFromKits < ActiveRecord::Migration[5.1]
  def change
    remove_column :kits, :images, :string
  end
end
