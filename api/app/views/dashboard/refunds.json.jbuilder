# frozen_string_literal: true

json.refunds @refunds do |refund|
  json.partial! refund
end
