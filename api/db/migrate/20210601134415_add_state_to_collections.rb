class AddStateToCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :state, :integer, default: 0
  end
end
