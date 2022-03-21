# frozen_string_literal: true

module Api
  class RefundOrderItem < ApplicationRecord
    belongs_to :refund
    belongs_to :order_item
  end
end
