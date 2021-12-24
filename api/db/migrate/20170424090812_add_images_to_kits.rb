class AddImagesToKits < ActiveRecord::Migration[5.1]
  def change
    add_column :kits, :images, :json
  end
end
