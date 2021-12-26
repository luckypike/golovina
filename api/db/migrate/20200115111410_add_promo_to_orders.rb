class AddPromoToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :promo, :integer
  end
end
