class Accounts::PasswordsController < Accounts::ApplicationController
  before_action :authorize_password

  def show
    @user ||= User.with_reset_password_token(params[:reset_password_token])
    @user && @user.reset_password_token = params[:reset_password_token]
  end

  def update
    @user = User.reset_password_by_token(user_params)

    if @user.errors.empty?
      sign_in(@user)

      head :ok, location: account_path
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_password
    authorize :password
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :reset_password_token)
  end
end
