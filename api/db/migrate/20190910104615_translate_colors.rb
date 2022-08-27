# frozen_string_literal: true

class TranslateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :color_translations do |t|
      t.references :color, foreign_key: true
      t.string :locale
      t.string :title

      t.timestamps
    end
  end
end
