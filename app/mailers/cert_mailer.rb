class CertMailer < ApplicationMailer
  # helper 'action_view/helpers/number'
  # helper :products

  def payed
    @cert = params[:cert]
    pp params
    attachments.inline['golovina.png'] = File.read('app/javascript/images/golovina.png')

    mail(to: @cert.user.email, subject: "Оплачен сертификат № #{@cert.number}")
  end
end
