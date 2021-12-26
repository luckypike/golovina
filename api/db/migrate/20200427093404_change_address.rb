class ChangeAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :address, :address_old

    add_column :orders, :street, :string
    add_column :orders, :house, :string
    add_column :orders, :appartment, :string

    add_column :orders, :comment, :text
  end
end
