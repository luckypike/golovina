# frozen_string_literal: true

class StatisticsController < ApplicationController
  def index
    authorize Order

    @items = Order.not_cart + Api::Refund.includes([:order, { refund_order_items: :order_item }]).state_archived
  end
end
