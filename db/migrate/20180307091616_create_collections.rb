class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :title
      t.string :slug
      t.text :text

      t.timestamps
    end
    add_index :collections, :slug, unique: true
  end
end
