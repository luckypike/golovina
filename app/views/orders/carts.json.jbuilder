json.carts @carts.group_by(&:user_id).each do |user_id, cart|
  user = cart.map{ |u| u.user }.uniq
  quantity = cart.map{ |q| q.quantity }.sum
  amount = cart.map{ |v| v.variant.price }.sum.round
  created_at = cart.map{ |c| c.created_at.strftime('%d.%m.%y') }

  json.id user_id
  json.quantity quantity
  json.user user
  json.amount amount
  json.created_at created_at

  json.items cart do |item|
    json.extract! item, :id, :quantity
    json.variant item.variant, partial: 'variants/variant', as: :variant
    json.color item.variant.color, partial: 'colors/color', as: :color
    json.size item.size, partial: 'sizes/size', as: :size
    json.quantity_available item.available
    json.available item.available?
  end
end
