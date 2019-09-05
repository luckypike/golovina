class ChangeDefaultVariantsState < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:variants, :state, from: 1, to: nil)
  end
end
