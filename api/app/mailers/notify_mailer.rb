class NotifyMailer < ApplicationMailer
  def notify_mailer(mail, variant)
    @variant = variant
    mail(to: mail, subject: I18n.t('mailers.subjects.notify'))
  end
end
