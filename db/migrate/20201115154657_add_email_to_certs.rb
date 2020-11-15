class AddEmailToCerts < ActiveRecord::Migration[6.0]
  def change
    add_column :certs, :email, :string
  end
end
