class NotifyMailer < ApplicationMailer
  def notify_mailer(notification)
    @variant = notification.variant
    mail(to: notification.user.email, subject: 'Уведомление о поступлении товара')
  end
end
