class AddWeightToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :weight, :integer, default: 0
  end
end
