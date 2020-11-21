class AddZipToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :zip, :string
  end
end
