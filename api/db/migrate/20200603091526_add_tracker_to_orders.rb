class AddTrackerToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :tracker_type, :integer
    add_column :orders, :tracker_id, :string
  end
end
