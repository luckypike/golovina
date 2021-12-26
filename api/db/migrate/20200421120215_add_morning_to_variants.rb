class AddMorningToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :morning, :boolean
  end
end
