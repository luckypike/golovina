class DashboardController < ApplicationController
  before_action :authorize_dashboard

  def index
    @orders = Order.paid.includes(:user).with_items.order(payed_at: :desc)
  end

  def archived
    @orders = Order.archived.includes(:user).with_items.order(payed_at: :desc)
  end

  def cart
    @orders = Order.cart.includes(:user).with_items
      .where('updated_at > ?', Time.current - 3.months)
      .order(updated_at: :desc)
  end

  def refunds
    @refunds = Refund.includes(:user).with_items.order(id: :desc)
  end

  def wishlists
    @wishlists = Wishlist.with_variant.includes(:user)
      .where('created_at > ?', 3.months.ago)
      .order(created_at: :desc)
  end

  private

  def authorize_dashboard
    authorize :dashboard
  end
end
