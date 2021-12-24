class FillPayedAt < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE orders o
          SET payed_at = updated_at
          WHERE payed_at IS NULL
        SQL
      end
    end
  end
end
