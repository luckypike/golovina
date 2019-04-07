# TODO: Переписать очистку телефона

require 'sms'

class SessionsController < ApplicationController
  def login
    authorize :static, :index?

    redirect_to [:orders, Current.user] if Current.user && !Current.user.guest?

    @user = User.new
  end


  def code
    authorize :static, :index?

    phone = User.prepare_phone(params[:user][:phone])

    if phone
      user = User.find_by_phone(phone)

      if user
        code = rand.to_s[2..5]
        user.update_attribute(:code, code)
        user.update_attribute(:code_last, Time.now)
        Sms.message(user.phone, user.code)
        head :ok
      else
        render json: { message: 'Не найдет такой номер телефона' }, status: :not_found
      end
    else
      render json: { message: 'Неверный номер телефона' }, status: :bad_request
    end
  end

  def auth
    authorize :static, :index?

    user = User.find_by(phone: User.prepare_phone(params[:user][:phone]), code: params[:user][:code])
    if user
      if Current.user && Current.user.guest?
        Cart.where(user: current_user).update_all(user_id: user.id)
      end
      sign_in(user)
      redirect_to root_path
    else
      redirect_to [:login]
    end
  end
end
