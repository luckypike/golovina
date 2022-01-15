# frozen_string_literal: true

module Variants
  class CreateOrUpdateContract < ApplicationContract
    config.messages.namespace = :variant

    rule(:price_last) do
      if value.present?
        key.failure(:price_empty?) if values[:price].blank?
        key.failure(:price_last_gt?) if values[:price].present? && value >= values[:price]
      end
    end
  end
end
