class UsersController < ApplicationController
  before_action :set_user, only: [:orders]

  def orders
    authorize @user
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
