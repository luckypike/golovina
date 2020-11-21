class AddZipToUserAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_addresses, :zip, :string
  end
end
