class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets[:mail_username]
  layout 'mailer'
end
