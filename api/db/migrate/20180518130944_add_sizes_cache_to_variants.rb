class AddSizesCacheToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :sizes_cache, :jsonb
  end
end
