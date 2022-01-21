# frozen_string_literal: true

class AddActiveToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :active, :boolean
  end
end
