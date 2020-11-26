class AddSimgleToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :single, :boolean, default: false
  end
end
