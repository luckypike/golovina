class AddBrandToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :brand, :integer

    Product.where('title ilike ?', "%golovina%").update(brand: 1)
  end
end
