class TranslateVariants < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Variant.create_translation_table!(
          { desc: :text, comp: :text },
          migrate_data: true
        )
      end

      dir.down do
        Variant.drop_translation_table!
      end
    end
  end
end
