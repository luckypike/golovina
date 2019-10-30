class AddStateIndexToVariants < ActiveRecord::Migration[5.2]
  def change
    add_index :variants, :state
    add_index :variants, :sale
    add_index :variants, :latest
    add_index :variants, :pinned
    add_index :variants, :last
  end
end
