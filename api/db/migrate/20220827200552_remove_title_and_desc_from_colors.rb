# frozen_string_literal: true

class RemoveTitleAndDescFromColors < ActiveRecord::Migration[6.1]
  def change
    remove_column :colors, :title, :string
    remove_column :colors, :desc, :text
  end
end
