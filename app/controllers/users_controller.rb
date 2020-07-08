class UsersController < ApplicationController
  before_action :set_user, only: [:orders, :refunds]

  def index
    authorize User

    @users = User.common
  end

  def orders
    authorize @user

    respond_to do |format|
      format.html
      format.json do
        @orders = @user.orders
          .includes(
            :user,
            :delivery_city,
            order_items: [
              :size,
              variant: [
                { color: [{ colors: :translations }, :translations] },
                :translations
              ]
            ]
          ).where.not(state: [:undef]).order(created_at: :desc)
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
      redirect_to [:new_user_session]
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
