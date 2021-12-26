class AddLastToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :last, :boolean, default: false
  end
end
