class MoveActiveOrdersToCart < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          DELETE FROM order_items
          WHERE order_id IN (SELECT id FROM orders WHERE state = 0)
        SQL

        execute <<-SQL
          DELETE FROM orders o
          WHERE state = 0
        SQL

        execute <<-SQL
          UPDATE orders o
          SET state = 0
          WHERE state = 1
        SQL
      end
    end
  end
end
