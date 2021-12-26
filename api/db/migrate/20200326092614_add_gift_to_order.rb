class AddGiftToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :gift, :integer
  end
end
