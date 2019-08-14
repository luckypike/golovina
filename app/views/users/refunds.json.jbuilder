json.refunds @refunds do |refund|
  json.partial! 'refunds/refund', refund: refund
  json.user refund.user, partial: 'users/user', as: :user
  json.items refund.order_items do |item|
    json.extract! item, :id, :quantity
    json.variant item.variant, partial: 'variants/variant', as: :variant
    json.color item.variant.color, partial: 'colors/color', as: :color
    json.price item.price_sell
    json.size item.size, partial: 'sizes/size', as: :size
  end
end
