class UsersController < ApplicationController
  before_action :set_user, only: [:orders]

  def orders
    authorize @user
    @orders = @user.orders
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
