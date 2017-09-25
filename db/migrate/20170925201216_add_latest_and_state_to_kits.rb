class AddLatestAndStateToKits < ActiveRecord::Migration[5.1]
  def change
    add_column :kits, :latest, :boolean, default: false
    add_column :kits, :state, :integer, default: 0

    Kit.update_all(state: :active)
  end
end
