class RemoveFieldsFromVariants < ActiveRecord::Migration[5.2]
  def change
    remove_column :variants, :themes, :jsonb
  end
end
