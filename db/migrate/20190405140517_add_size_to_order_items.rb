class AddSizeToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :size, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE order_items SET size_id = size WHERE size IN (SELECT id FROM sizes)
        SQL

        execute <<-SQL
          UPDATE order_items SET size_id = NULL WHERE size NOT IN (SELECT id FROM sizes)
        SQL

      end

      dir.down do
        execute <<-SQL
          UPDATE order_items SET size = size_id
        SQL
      end
    end

    remove_column :order_items, :size, :integer
  end
end
