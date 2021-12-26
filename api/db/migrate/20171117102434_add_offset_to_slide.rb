class AddOffsetToSlide < ActiveRecord::Migration[5.1]
  def change
    add_column :slides, :left_offset, :integer
    add_column :slides, :top_offset, :integer
  end
end
