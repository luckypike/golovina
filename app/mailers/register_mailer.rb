class RegisterMailer < ApplicationMailer
  def register_mailer password, user
    @user = user
    pp @user
    @password = password
    mail(to: user.email, subject: 'Уведомление о регистрации пользователя')
  end
end
