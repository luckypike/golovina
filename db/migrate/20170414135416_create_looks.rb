class CreateLooks < ActiveRecord::Migration[5.1]
  def change
    create_table :looks do |t|
      t.string :title

      t.timestamps
    end
  end
end
