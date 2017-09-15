class OrderMailer < ApplicationMailer
  def checkout order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: Rails.application.secrets[:order_title])
  end
end
