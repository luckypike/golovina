class CreateUserAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :delivery_city, foreign_key: true
      t.string :street
      t.string :house
      t.string :appartment

      t.timestamps
    end
  end
end
