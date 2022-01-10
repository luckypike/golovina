# frozen_string_literal: true

module Categories
  class ProcessCmd < ApplicationCmd
    input :category

    def call
      category.update(variants_and_kits_count: category.variants.active.size + category.kits.active.size)
    end
  end
end
