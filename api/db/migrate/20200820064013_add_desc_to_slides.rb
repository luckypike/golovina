class AddDescToSlides < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        Slide.add_translation_fields! desc: :text
      end

      dir.down do
        remove_column :slide_translations, :desc
      end
    end
  end
end
