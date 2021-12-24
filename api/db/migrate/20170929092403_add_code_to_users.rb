class AddCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :code, :integer
    add_column :users, :code_last, :datetime
  end
end
