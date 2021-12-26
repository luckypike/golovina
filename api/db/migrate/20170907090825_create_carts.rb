class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.references :variant, foreign_key: true
      t.integer :quantity, default: 1
      t.integer :size

      t.timestamps
    end
  end
end
