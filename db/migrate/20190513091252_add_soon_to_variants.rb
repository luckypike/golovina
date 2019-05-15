class AddSoonToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :soon, :boolean, default: false 
  end
end
