# frozen_string_literal: true

class FixComeIndexesInColors < ActiveRecord::Migration[6.1]
  def change
    remove_column :colors, :slug, :string
    add_foreign_key :colors, :colors, column: :parent_color_id, primary_key: :id
  end
end
