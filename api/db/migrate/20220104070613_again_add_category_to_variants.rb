# frozen_string_literal: true

class AgainAddCategoryToVariants < ActiveRecord::Migration[6.0]
  def change
    add_reference :variants, :category, foreign_key: true
  end
end
