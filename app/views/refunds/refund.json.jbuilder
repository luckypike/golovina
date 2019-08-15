json.orders @orders do |order|
  json.partial! 'orders/order', order: order
  json.items order.order_items do |item|
    json.extract! item, :id, :quantity
    json.variant item.variant, partial: 'variants/variant', as: :variant
    json.price_sell item.price_sell
    json.color item.variant.color, partial: 'colors/color', as: :color
    json.size item.size, partial: 'sizes/size', as: :size
    json.refund item.refund.present?
  end
end
