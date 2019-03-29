class AddSizeToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :size, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          DELETE FROM carts WHERE size NOT IN (SELECT id FROM sizes)
        SQL

        execute <<-SQL
          UPDATE carts SET size_id = size
        SQL
      end

      dir.down do
        execute <<-SQL
          UPDATE carts SET size = size_id
        SQL
      end
    end

    remove_column :carts, :size, :integer
  end
end
