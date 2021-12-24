class AddLogoToSlides < ActiveRecord::Migration[5.1]
  def change
    add_column :slides, :logo, :integer, default: 0
  end
end
