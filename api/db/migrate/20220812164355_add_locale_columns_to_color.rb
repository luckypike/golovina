# frozen_string_literal: true

class AddLocaleColumnsToColor < ActiveRecord::Migration[6.1]
  def change # rubocop:disable Metrics/MethodLength
    add_column :colors, :title_ru, :string
    add_column :colors, :title_en, :string

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE colors c
          SET
            title_ru = (SELECT title FROM color_translations ct WHERE ct.locale = 'ru' AND c.id = ct.color_id),
            title_en = (SELECT title FROM color_translations ct WHERE ct.locale = 'en' AND c.id = ct.color_id)
        SQL
      end
    end
  end
end
