class ApplicationMailer < ActionMailer::Base
  default from: "Golovina <#{Rails.application.credentials[Rails.env.to_sym][:mail][:username]}>"
  layout 'mailer'
end
