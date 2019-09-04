class TranslateProducts < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Product.create_translation_table!(
          { title: :string },
          migrate_data: true
        )
      end

      dir.down do
        Product.drop_translation_table!
      end
    end
  end
end
