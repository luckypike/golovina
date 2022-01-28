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

  def payed
    @season_color =
      case Time.current.month
      when 1..2, 12
        '#53565a'
      when 3..5
        '#dfc2c3'
      when 6..8
        '#656635'
      when 9..11
        '#a9431e'
      end
    @order = params[:order]
    @fast = @order.russia? && @order.door? && @order.delivery_city.fast?
    attachments.inline['logo-white.png'] = File.read('public/logo-white.png')
    attachments.inline['logo-black.png'] = File.read('public/logo-black.png')

    mail(to: @order.user.email, subject: "Оплачен заказ № #{@order.number}")
  end

  def refund refund
    @refund = refund
    mail(to: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:mail], subject: "Оформлен возврат на заказ № #{refund.order.number}")
  end

  def tracker
    @order = params[:order]
    attachments.inline['golovina.png'] = File.read('app/javascript/images/golovina.png')

    mail(to: @order.user.email, subject: "Трек номер для заказа № #{@order.number}")
  end
end
