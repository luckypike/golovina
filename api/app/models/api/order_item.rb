# frozen_string_literal: true

module Api
  class OrderItem < ApplicationRecord
    belongs_to :size
    belongs_to :variant
  end
end
