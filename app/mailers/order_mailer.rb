class OrderMailer < ApplicationMailer
  # include ActionView::Helpers::NumberHelper
  helper 'action_view/helpers/number'
  helper :products

  def activate order
    @order = order
    mail(to: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:mail], subject: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:prefix] + " создан заказ № #{order.number}")
  end

  def pay order
    @order = order
    mail(to: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:mail], subject: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:prefix] + " оплачен заказ № #{order.number}")
  end

  def sms_test order
    @order = order
    mail(to: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:mail], subject: 'Тестовая СМС')
  end
end
