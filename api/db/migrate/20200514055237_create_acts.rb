class CreateActs < ActiveRecord::Migration[6.0]
  def change
    create_table :acts do |t|
      t.integer :quantity
      t.references :availability, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO acts(availability_id, store_id, quantity, created_at, updated_at)
          SELECT id, store_id, quantity, updated_at, updated_at
          FROM availabilities
          WHERE quantity > 0
        SQL
      end
    end
  end
end
