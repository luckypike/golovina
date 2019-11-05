class RegisterMailer < ApplicationMailer
  def register_mailer(password, user)
    @user = user
    @password = password
    mail(to: user.email, subject: 'Уведомление о регистрации пользователя')
  end

  alias order_mailer register_mailer
  alias notify_mailer register_mailer
end
