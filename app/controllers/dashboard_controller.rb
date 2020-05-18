class DashboardController < ApplicationController
  before_action :authorize_dashboard

  def index
    @orders = Order.paid.with_items.order(payed_at: :desc)
  end

  def archived
    @orders = Order.archived.with_items.order(payed_at: :desc)
  end

  def cart
    @orders = Order.cart.with_items.order(payed_at: :desc)
  end

  private

  def authorize_dashboard
    authorize :dashboard
  end
end
