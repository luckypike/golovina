# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :key
      t.string :value
      t.datetime :expires_at

      t.timestamps
    end
  end
end
