# frozen_string_literal: true

class AddIndexesToCategories < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, :state
  end
end
