# frozen_string_literal: true

class AddImagesCountToVariants < ActiveRecord::Migration[6.1]
  def change
    add_column :variants, :images_count, :integer
  end
end
