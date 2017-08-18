class DropKinds < ActiveRecord::Migration[5.1]
  def change
    drop_table :kinds
  end
end
