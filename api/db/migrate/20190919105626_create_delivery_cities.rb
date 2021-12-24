class CreateDeliveryCities < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_cities do |t|
      t.string :title
      t.integer :door
      t.string :door_days
      t.integer :storage
      t.string :storage_days

      t.timestamps
    end
  end
end
