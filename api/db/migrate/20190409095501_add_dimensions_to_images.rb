class AddDimensionsToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :height, :int
    add_column :images, :width, :int
  end
end
