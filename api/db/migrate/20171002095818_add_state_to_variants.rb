class AddStateToVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :state, :integer, default: 1

    Variant.find_each do |variant|
      variant.out! if variant.out_of_stock
    end
  end
end
