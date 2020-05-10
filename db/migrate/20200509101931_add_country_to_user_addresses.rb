class AddCountryToUserAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_addresses, :city, :string
    add_column :user_addresses, :country, :string
    add_column :user_addresses, :delivery_option, :integer

    add_column :orders, :city, :string
    add_column :orders, :country, :string
  end
end
