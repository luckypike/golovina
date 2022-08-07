class SessionsController < Devise::SessionsController
  before_action :authorize_session
  skip_before_action :require_no_authentication

  def new
    redirect_to [:account] if current_user&.common?

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
  end

  def create
    user = User.find_for_database_authentication(email: params[:user][:email].squish)
    if user&.valid_password?(params[:user][:password].squish)
      if current_user&.guest?
        # Cart.where(user: Current.user).update_all(user_id: user.id)
        # Wishlist.where(user: Current.user).update_all(user_id: user.id)
      end

      sign_in(user)
      cookies[:_golovina_jwt] = Sessions::SetJwtSessionCmd.call(user: user).token
      head :ok, location: after_sign_in_path_for(user)
    else
      render json: { message: t('messages.password') }, status: :unauthorized
    end
  end

  def recovery
    if (user = User.find_for_database_authentication(email: params[:user][:email].squish))
      user.send_reset_password_instructions
      head :ok
    else
      render json: { message: t('messages.email') }, status: :not_found
    end
  end

  def destroy
    sign_out

    head :ok, location: '/'
  end

  private

  def authorize_session
    authorize :session
  end
end
