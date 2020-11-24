class AddPublishedAtToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :published_at, :date
  end
end
