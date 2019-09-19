class AddCityToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :delivery_city, foreign_key: true
  end
end
