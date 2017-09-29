# TODO: Переписать очистку телефона

require 'sms'

class SessionsController < ApplicationController
  def login
    authorize :static, :index?

    @user = User.new
  end


  def code
    authorize :static, :index?

    params[:user][:phone] ||= 'XXX'

    user = User.find_by_phone(params[:user][:phone].sub('/^8/', '+7').gsub(/[\D]/, ''))

    if user
      code = rand.to_s[2..5]
      user.update_attribute(:code, code)
      user.update_attribute(:code_last, Time.now)
      Sms.message(user.phone, user.code)
      head :ok
    else
      render json: { status: :not_found }
    end
  end

  def auth
    authorize :static, :index?
    user = User.find_by(phone: params[:user][:phone].sub('/^8/', '+7').gsub(/[\D]/, ''), code: params[:user][:code])
    if user
      if current_user && current_user.is_guest?
        Cart.where(user: current_user).update_all(user_id: user.id)
      end
      sign_in(user)
      redirect_to root_path
    else
      redirect_to [:login]
    end
  end
end
