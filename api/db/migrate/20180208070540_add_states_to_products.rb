class AddStatesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :state_auto, :boolean, default: false
    rename_column :products, :state, :state_manual
  end
end
