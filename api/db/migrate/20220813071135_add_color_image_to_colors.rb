# frozen_string_literal: true

class AddColorImageToColors < ActiveRecord::Migration[6.1]
  def change
    add_column :colors, :color_image, :string
  end
end
