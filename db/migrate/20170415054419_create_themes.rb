class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end

    add_index :themes, :slug, unique: true
  end
end
