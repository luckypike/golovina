class TranslateThemes < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      remove_reference :kits, :theme

      dir.up do
        execute <<-SQL
          DELETE FROM themables
        SQL

        execute <<-SQL
          DELETE FROM themes
        SQL

        Theme.create_translation_table! title: :string, desc: :text
      end

      dir.down do
        Theme.drop_translation_table!
      end
    end
  end
end
