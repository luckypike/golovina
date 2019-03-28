class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :variant, foreign_key: true
      t.references :size, foreign_key: true
      t.integer :count

      t.timestamps
    end

    remove_column :variants, :sizes, :jsonb
  end
end
