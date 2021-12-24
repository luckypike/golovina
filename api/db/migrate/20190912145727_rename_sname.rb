class RenameSname < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :s_name, :sname
  end
end
