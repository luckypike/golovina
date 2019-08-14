class UsersController < ApplicationController
  before_action :set_user, only: [:orders, :refunds]

  layout 'app'

  def orders
    authorize @user

    respond_to do |format|
      format.html
      format.json do
        @orders = @user.orders.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where.not(state: [:undef]).order(created_at: :desc)
        @orders = @orders.where(state: params[:state]) if params[:state]
      end
    end
  end

  def refunds
    authorize @user

    respond_to do |format|
      format.html
      format.json do
        @refunds = @user.refunds.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]})
      end
    end
  end

  def account
    authorize User

    if signed_in?
      redirect_to [:orders, Current.user]
    else
      redirect_to [:login]
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
