class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.references :product, foreign_key: true
      t.references :color, foreign_key: true
      t.jsonb :sizes

      t.timestamps
    end
  end
end
