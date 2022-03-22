# frozen_string_literal: true

class TruncateUserRefs < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          DELETE FROM carts
        SQL

        execute <<-SQL.squish
          DELETE FROM notifications
        SQL
      end
    end
  end
end
