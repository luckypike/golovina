class CreateSlides < ActiveRecord::Migration[5.1]
  def change
    create_table :slides do |t|
      t.string :name
      t.string :link
      t.string :image

      t.timestamps
    end
  end
end
