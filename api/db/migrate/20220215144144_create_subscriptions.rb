# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth, null: false
      t.integer :state, null: false
      t.string :locale, null: false

      t.timestamps
    end

    add_index :subscriptions, :email, unique: true
  end
end
