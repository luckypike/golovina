# frozen_string_literal: true

class RegisterMailer < ApplicationMailer
  def register_mailer(password, user)
    @user = user
    @password = password
    mail(to: user.email, subject: I18n.t("mailers.subjects.register"))
  end

  alias order_mailer register_mailer
  alias notify_mailer register_mailer
end
