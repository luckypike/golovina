class CreateSimilarables < ActiveRecord::Migration[5.1]
  def change
    create_table :similarables do |t|
      t.references :product, foreign_key: true
      t.references :similar_product

      t.timestamps
    end
  end
end
