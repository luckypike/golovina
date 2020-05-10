class AddUserAddressToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :user_address, foreign_key: true
  end
end
