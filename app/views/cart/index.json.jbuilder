json.carts @carts do |cart|
  json.extract! cart, :id, :quantity
  json.variant cart.variant, partial: 'variants/variant', as: :variant
  json.color cart.variant.color, partial: 'colors/color', as: :color
  json.size cart.size, partial: 'sizes/size', as: :size
  json.quantity_available cart.available
  json.available cart.available?
end

json.price do
  json.sell @carts.sum(&:price_sell)
  json.origin @carts.sum(&:price)
end

json.values do
  json.address ''

  json.user_attributes do
    json.name @user.name || ''
    json.sname @user.sname || ''
    json.phone @user.phone || ''
    json.email((@user.guest? ? '' : @user.email) || '')
  end
end
