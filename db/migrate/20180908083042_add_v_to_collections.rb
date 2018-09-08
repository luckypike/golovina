class AddVToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :v, :string
  end
end
