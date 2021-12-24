class AddBestsellerToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :bestseller, :boolean
  end
end
