# frozen_string_literal: true

namespace :migrate do
  namespace :order_items do
    desc "Add discount"
    task add_discount_to_amount: :environment do
      Api::Order.where(state: %i[paid archived]).where.not(promo_code_id: nil).find_each do |order|
        order.order_items.each do |order_item|
          order_item.update(amount: order.promo_code.apply(order_item.amount))
        end
      end
    end
  end
end
