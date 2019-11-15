class NotifyMailer < ApplicationMailer
  def notify_mailer(mail, variant)
    @variant = variant
    mail(to: mail, subject: 'Уведомление о поступлении товара')
  end
end
