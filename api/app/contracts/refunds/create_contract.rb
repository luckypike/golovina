# frozen_string_literal: true

module Refunds
  class CreateContract < ApplicationContract
    Reasons = Dry::Types["strict.string"].enum(*Api::Refund.reasons.keys)

    params do
      required(:order_id).filled(:integer)
      required(:reason).filled(Reasons)
      optional(:detail).maybe(:str?)
      required(:order_item_ids).value(:array, min_size?: 1).each(:integer)
    end

    rule(:detail) do
      key.failure(:filled?) if value.blank? && %w[other].include?(values[:reason])
    end
  end
end
