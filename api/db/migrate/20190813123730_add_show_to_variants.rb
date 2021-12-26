class AddShowToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :show, :boolean, default: true
  end
end
