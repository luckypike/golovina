class StatisticsController < ApplicationController
  def index
    authorize Order

    @items = Order.not_cart + Refund.includes(:order, :order_items).done
  end
end
