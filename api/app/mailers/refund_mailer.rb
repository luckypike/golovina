# frozen_string_literal: true

class RefundMailer < ApplicationMailer
  def create
    @refund = params[:refund]
    mail(to: Figaro.env.mail_to, subject: Figaro.env.mail_prefix + " оформлен возврат на заказ № #{@refund.order.id}")
  end
end
