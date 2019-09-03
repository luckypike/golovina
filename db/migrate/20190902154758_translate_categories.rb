class TranslateCategories < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Category.create_translation_table!(
          { title: :string },
          migrate_data: true
        )
      end

      dir.down do
        Category.drop_translation_table! migrate_data: true
      end
    end
  end
end
