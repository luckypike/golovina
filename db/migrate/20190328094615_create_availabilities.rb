class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :variant, foreign_key: true
      t.references :size, foreign_key: true
      t.integer :count

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Variant.find_each do |variant|
          JSON.parse(variant.sizes_before_type_cast).each do |size, count|
            variant.availabilities.create(count: count, size_id: size.to_i)
          end
        end
      end
    end

    remove_column :variants, :sizes, :jsonb
  end
end
