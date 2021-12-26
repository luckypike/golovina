class CreatePromos < ActiveRecord::Migration[5.2]
  def change
    create_table :promos do |t|
      t.string :title
      t.string :link
      t.boolean :front
      t.boolean :popup

      t.timestamps
    end
  end
end
