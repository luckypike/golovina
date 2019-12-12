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
  json.phone @user.phone || ''
  json.delivery I18n.locale == :en ? :international : ''

  json.user_attributes do
    json.name @user.name || ''
    json.sname @user.sname || ''
    json.email((@user.guest_email? ? '' : @user.email) || '')
  end
end

json.dictionaries do
  json.delivery_cities DeliveryCity.all
end
