class AddDescToCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :desc, :string
  end
end
