class AddFavouriteToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :favourite, :boolean, default: false
  end
end
