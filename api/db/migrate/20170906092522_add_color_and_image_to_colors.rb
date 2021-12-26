class AddColorAndImageToColors < ActiveRecord::Migration[5.1]
  def change
    add_column :colors, :color, :string
    add_column :colors, :image, :string
  end
end
