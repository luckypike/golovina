class CreateKits < ActiveRecord::Migration[5.1]
  def change
    create_table :kits do |t|
      t.string :title

      t.timestamps
    end
  end
end
