# frozen_string_literal: true

class CreatePromoCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :promo_codes do |t|
      t.integer :discount, null: false
      t.decimal :value, null: false
      t.integer :state, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :promo_codes, :title, unique: true
  end
end
