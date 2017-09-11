class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :variant, foreign_key: true
      t.integer :quantity
      t.integer :size

      t.timestamps
    end
  end
end
