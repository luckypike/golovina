class Accounts::UsersController < Accounts::ApplicationController
  before_action :authorize_user

  def show; end

  def password; end

  def update
    sleep 1

    if @user.update(user_params)
      bypass_sign_in(@user)
      head :ok, location: account_path
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_user
    authorize @user || User
  end

  def user_params
    params.require(:user).permit(
      :password, :password_confirmation,
      :name, :sname, :email, :phone
    )
  end
end
