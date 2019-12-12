# TODO: Переписать очистку телефона

require 'sms'

class SessionsController < Devise::SessionsController
  before_action :authorize_session
  skip_before_action :require_no_authentication

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)

    redirect_to [:orders, Current.user] if Current.user && Current.user.common?
  end

  def create
    user = User.find_for_database_authentication(email: params[:user][:email].strip)
    if user && user.valid_password?(params[:user][:password])

      if Current.user && Current.user.guest?
        Cart.where(user: Current.user).update_all(user_id: user.id)
        Wishlist.where(user: Current.user).update_all(user_id: user.id)
      end

      sign_in user
      head :ok, location: root_path
    else
      render json: { message: 'Неверная почта или пароль' }, status: :unauthorized
    end
  end

  def phone
    phone = User.prepare_phone(params[:user][:phone])

    if phone && user = User.find_by_phone(phone)
      code = rand.to_s[2..5]
      user.update_attributes({ code: code, code_last: Time.now })
      Sms.message(user.phone, user.code) if Rails.env.production?
      head :ok
    else
      render json: { message: 'Не найден такой номер телефона' }, status: :not_found
    end
  end

  def code
    if user = User.find_by(phone: User.prepare_phone(params[:user][:phone].strip), code: params[:user][:code].strip)
      if Current.user && Current.user.guest?
        Cart.where(user: Current.user).update_all(user_id: user.id)
        Wishlist.where(user: Current.user).update_all(user_id: user.id)
      end

      sign_in user
      head :ok, location: root_path
    else
      render json: { message: 'Неверный код из SMS' }, status: :bad_request
    end
  end

  def recovery
    if user = User.find_for_database_authentication(email: params[:user][:email].strip)
      user.send_reset_password_instructions
      head :ok
    else
      render json: { message: 'Почта не найдена' }, status: :not_found
    end
  end

  def auth
    user = User.with_reset_password_token(params[:reset_password_token])
    if user
      sign_in(user)
    end
    redirect_to root_path
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    head :ok
  end

  private
  def authorize_session
    authorize :session
  end
end
