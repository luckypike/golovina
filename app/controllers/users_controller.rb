class UsersController < ApplicationController
  before_action :set_user, only: [:orders]
  before_action :set_sizes, only: [:orders]

  def orders
    authorize @user
    @orders = @user.orders.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where.not(state: [:undef]).order(created_at: :desc)
    @orders = @orders.where(state: params[:state]) if params[:state]
  end

  def account
    authorize User
    if signed_in? && !current_user.is_guest?
      redirect_to [:orders, current_user]
    else
      redirect_to [:login]
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
