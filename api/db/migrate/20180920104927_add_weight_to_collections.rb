class AddWeightToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :weight, :integer, default: 0
  end
end
