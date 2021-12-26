class AddStateToActs < ActiveRecord::Migration[6.0]
  def change
    add_column :acts, :state, :integer, default: 1
  end
end
