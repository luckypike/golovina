class AddActsCountToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :acts_count, :integer, null: false, default: 0
  end
end
