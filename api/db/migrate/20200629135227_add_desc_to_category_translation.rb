class AddDescToCategoryTranslation < ActiveRecord::Migration[6.0]
  def change
    add_column :category_translations, :desc, :text
  end
end
