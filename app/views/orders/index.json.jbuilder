json.orders @orders do |order|
  json.partial! 'orders/order', order: order
  json.user order.user, partial: 'users/user', as: :user
  json.items order.order_items do |item|
    json.extract! item, :id, :quantity
    json.variant item.variant, partial: 'variants/variant', as: :variant
    json.color item.variant.color, partial: 'colors/color', as: :color
    json.size item.size, partial: 'sizes/size', as: :size
    json.quantity_available 0
    json.available false
  end
end

json.states Order.states.keys.reject{|k| k == 'undef'}.map{|o| {key: o, title: t("order.state.#{o}")}}
