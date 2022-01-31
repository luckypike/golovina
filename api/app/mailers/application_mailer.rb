# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Golovina Mari <#{Rails.application.credentials[Rails.env.to_sym][:mail][:username]}>"
  layout 'mailer'
end
