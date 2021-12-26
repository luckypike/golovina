class AddTitleToVariants < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Variant.add_translation_fields! title: :string
      end

      dir.down do
        remove_column :variant_translations, :title
      end
    end
  end
end
