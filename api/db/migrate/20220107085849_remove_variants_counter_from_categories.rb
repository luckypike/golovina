# frozen_string_literal: true

class RemoveVariantsCounterFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :variants_counter, :integer
  end
end
