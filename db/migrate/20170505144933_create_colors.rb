class CreateColors < ActiveRecord::Migration[5.1]
  def change
    create_table :colors do |t|
      t.string :title
      t.string :slug
      t.text :desc
      t.references :parent_color, index: true

      t.timestamps
    end
    add_index :colors, :slug, unique: true
  end
end
