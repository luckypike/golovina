class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|

      t.references :user, foreign_key: true
      t.string :name
      t.string :phone
      t.integer :size

      t.timestamps
    end
  end
end
