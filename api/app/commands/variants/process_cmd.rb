# frozen_string_literal: true

module Variants
  class ProcessCmd < ApplicationCmd
    input :variant

    def call
      variant.__elasticsearch__.index_document unless Rails.env.test?
      variant.update!(images_count: variant.images.where(processed: true).size)

      CategoryProcessJob.perform_later(category: variant.category) if variant.category
    end
  end
end
