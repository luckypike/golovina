json.orders @orders do |order|
  json.extract! order, :id, :amount, :state, :address
  json.amount_human number_to_rub(order.amount)
  json.date l(order.created_at.to_date)
  json.name [order.user.name, order.user.s_name].join(' ').strip
  json.phone order.user.phone
  json.state_human t("order.state.#{order.state}")

  if policy(order).pay?
    json.can_pay true
    json.pay_path pay_order_path(order)
  end

  if policy(order).archive?
    json.archive_path archive_order_path(order)
  end

  json.items order.order_items do |item|
    json.id item.id
    json.title item.variant.product.title_safe
    json.price number_to_rub(item.item_price)
    json.quantity item.quantity
    json.color item.variant.color.title
    json.size @sizes[item.size]
    json.image item.variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first.photo.preview.url if item.variant.images.size > 0
  end
end
