# frozen_string_literal: true

class AddPhoneLegacyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_legacy, :string

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE users
          SET phone_legacy = phone
        SQL
      end
    end
  end
end
