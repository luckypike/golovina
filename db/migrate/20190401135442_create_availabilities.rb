class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :variant, foreign_key: true
      t.references :size, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :quantity

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        store_id = Store.first.id
        Variant.find_each do |variant|
          JSON.parse(variant.sizes_before_type_cast).each do |size, quantity|
            variant.availabilities.create(quantity: quantity, size_id: size.to_i, store_id: store_id) if quantity.to_i > 0
          end
        end
      end
    end

    remove_column :variants, :sizes, :jsonb
  end
end
