class StatisticsController < ApplicationController
  def index
    authorize Order

    @items = Order.where(state: [2, 3]).where.not(payment_amount: nil) + Refund.includes(:order_items).where(state: 2)
  end
end
