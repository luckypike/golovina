class AddStateToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :state, :integer, default: 0
  end
end
