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

  def customer_notice order, to
    @order = order
    mail(to: to, subject: "Оплачен заказ № #{order.number}")
  end

  def refund refund
    @refund = refund
    mail(to: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:mail], subject: "Оформлен возрат на заказ № #{refund.order.number}")
  end

  def tracker(order)
    @order = order

    mail(to: order.user.email, subject: "Трек номер для заказа № #{order.number}")
  end
end
