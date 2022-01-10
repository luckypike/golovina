# frozen_string_literal: true

class RemoveOldDataFromVariants < ActiveRecord::Migration[6.1]
  def change
    remove_column :variants, :desc, :text
    remove_column :variants, :comp, :text
    remove_column :variants, :premium, :boolean
    remove_column :variants, :stayhome, :boolean
    remove_column :variants, :morning, :boolean
    remove_column :variants, :linen, :boolean
    remove_column :variants, :spec, :boolean
  end
end
