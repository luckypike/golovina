class OrderMailer < ApplicationMailer
  # include ActionView::Helpers::NumberHelper
  helper 'action_view/helpers/number'
  helper :products

  def checkout order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: Rails.application.secrets[:order_title])
  end

  def sms_test order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: 'Тестовая СМС')
  end
end
