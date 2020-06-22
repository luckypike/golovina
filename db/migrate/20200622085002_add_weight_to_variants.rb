class AddWeightToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :weight, :integer, default: 0
  end
end
