class AddPhoneAndNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :name, :string
  end
end
