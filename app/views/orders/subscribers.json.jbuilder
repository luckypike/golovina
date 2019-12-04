json.subscribers @subscribers do |subscriber|
  json.id subscriber.id
  json.created_at subscriber.created_at.strftime('%d.%m.%y')

  json.user subscriber.user.slice(:email)
  json.variant subscriber.variant, partial: 'variants/variant', as: :variant
  json.color subscriber.variant.color, partial: 'colors/color', as: :color
end
