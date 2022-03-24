# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  # include ActionView::Helpers::NumberHelper
  helper "action_view/helpers/number"
  helper :products

  def activate(order)
    @order = order
    mail(to: Figaro.env.mail_to, subject: Figaro.env.mail_prefix + " создан заказ № #{order.id}")
  end

  def pay(order)
    @order = order
    mail(to: Figaro.env.mail_to, subject: Figaro.env.mail_prefix + " оплачен заказ № #{order.id}")
  end

  def payed
    @order = params[:order]
    @fast = @order.russia? && @order.door? && @order.delivery_city.fast?
    attachments.inline["logo-white.png"] = File.read("public/logo-white.png")
    attachments.inline["logo-black.png"] = File.read("public/logo-black.png")

    mail(to: @order.user.email, subject: "Оплачен заказ № #{@order.number}")
  end

  def tracker
    @order = params[:order]
    attachments.inline["logo-white.png"] = File.read("public/logo-white.png")
    attachments.inline["logo-black.png"] = File.read("public/logo-black.png")

    mail(to: @order.user.email, subject: "Трек номер для заказа № #{@order.number}")
  end
end
