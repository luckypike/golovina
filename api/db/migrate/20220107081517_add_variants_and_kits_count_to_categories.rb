# frozen_string_literal: true

class AddVariantsAndKitsCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :variants_and_kits_count, :integer
  end
end
