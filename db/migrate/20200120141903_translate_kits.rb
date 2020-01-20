class TranslateKits < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Kit.create_translation_table!(
          { title: :string },
          migrate_data: true
        )
      end

      dir.down do
        Kit.drop_translation_table!
      end
    end
  end
end
