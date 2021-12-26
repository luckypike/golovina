class AddWeightToSizes < ActiveRecord::Migration[5.2]
  def change
    add_column :sizes, :weight, :integer, default: 0
  end
end
