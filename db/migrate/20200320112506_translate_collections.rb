class TranslateCollections < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Collection.create_translation_table!(
          { title: :string, text: :text },
          migrate_data: true
        )
      end

      dir.down do
        Collection.drop_translation_table!
      end
    end
  end
end
