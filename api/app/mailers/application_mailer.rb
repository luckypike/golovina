# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Figaro.env.mail_from
  layout "mailer"
end
