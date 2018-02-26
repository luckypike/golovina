class OrderMailer < ApplicationMailer
  # include ActionView::Helpers::NumberHelper
  helper 'action_view/helpers/number'
  helper :products

  def activate order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: Rails.application.secrets[:order_prefix] + " создан заказ № #{order.number}")
  end

  def pay order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: Rails.application.secrets[:order_prefix] + " оплачен заказ № #{order.number}")
  end

  def sms_test order
    @order = order
    mail(to: Rails.application.secrets[:order_mail], subject: 'Тестовая СМС')
  end
end
