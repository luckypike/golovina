class AddPremiumToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :premium, :boolean
    add_column :variants, :stayhome, :boolean
  end
end
