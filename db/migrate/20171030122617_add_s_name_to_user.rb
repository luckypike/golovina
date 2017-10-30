class AddSNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :s_name, :string
  end
end
