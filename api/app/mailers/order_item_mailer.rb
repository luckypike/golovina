class OrderItemMailer < ApplicationMailer
  def unallocated_quantity(order_item, unallocated_quantity)
    @order_item = order_item
    @unallocated_quantity = unallocated_quantity
    mail(
      to: 'log@luckypike.com',
      subject: Rails.application.credentials[Rails.env.to_sym][:mail][:order][:prefix] +
        " ошибка распределения в заказе № #{order_item.order.number}"
    )
  end
end
