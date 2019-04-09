class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :title
      t.text :address
    end

    Store.create()
  end
end
