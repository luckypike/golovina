# frozen_string_literal: true

class AddIndexesToThemes < ActiveRecord::Migration[6.1]
  def change
    add_index :themes, :state
  end
end
