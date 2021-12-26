class AddVariantToKitables < ActiveRecord::Migration[5.1]
  def change
    add_reference :kitables, :variant, foreign_key: true

    Kitable.find_each do |kitable|
      kitable.update(variant: kitable.product.variants.first)
    end
  end
end
