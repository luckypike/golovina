class AddDescToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :desc, :text
  end
end
