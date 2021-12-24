class AddLabelsToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :sale, :boolean, default: false
    add_column :variants, :latest, :boolean, default: false
    add_column :variants, :pinned, :boolean, default: false

    add_column :variants, :comp, :text
  end
end
