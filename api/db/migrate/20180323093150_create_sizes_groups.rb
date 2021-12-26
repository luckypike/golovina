class CreateSizesGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :sizes_groups do |t|
      t.string :title

      t.timestamps
    end
  end
end
