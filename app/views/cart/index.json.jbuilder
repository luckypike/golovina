json.carts @carts do |cart|
  json.extract! cart, :id, :quantity
  json.variant cart.variant, partial: 'variants/variant', as: :variant
  json.color cart.variant.color, partial: 'colors/color', as: :color
  json.size cart.size, partial: 'sizes/size', as: :size
  json.quantity_available cart.available
  json.available cart.available?
end

json.amount @carts.sum(&:price_sell)

if @carts.size > 0
  json.user @user, :id, :name, :s_name, :phone
  json.values do
    json.name @user.name || ''
    json.s_name @user.s_name || ''
    json.phone @user.phone || ''
    json.email (@user.guest? ? '' : @user.email) || ''
    json.address ''
  end
end
