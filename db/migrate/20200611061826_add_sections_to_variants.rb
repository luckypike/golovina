class AddSectionsToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :linen, :boolean, default: false
    add_column :variants, :spec, :boolean, default: false
  end
end
