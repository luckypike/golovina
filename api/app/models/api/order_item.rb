# frozen_string_literal: true

module Api
  class OrderItem < ApplicationRecord
    belongs_to :size
    belongs_to :variant

    def price
      variant.price * quantity
    end

    def price_final
      variant.price_final * quantity
    end
  end
end
