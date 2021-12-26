class CreateThemables < ActiveRecord::Migration[5.1]
  def change
    create_table :themables do |t|
      t.references :product, foreign_key: true
      t.references :theme, foreign_key: true

      t.timestamps
    end

    add_column :variants, :themes, :jsonb
  end
end
