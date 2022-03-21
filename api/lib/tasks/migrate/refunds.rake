# frozen_string_literal: true

namespace :migrate do
  desc "Remove nested categories"
  task refunds: :environment do
    OrderItem.where.not(refund_id: nil).each do |order_item|
      Api::RefundOrderItem.create(refund_id: order_item.refund_id, order_item_id: order_item.id)
    end
  end
end
