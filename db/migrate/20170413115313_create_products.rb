class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :category, foreign_key: true
      t.decimal :price
      t.text :desc

      t.timestamps
    end
  end
end
