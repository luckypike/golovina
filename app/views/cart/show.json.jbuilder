json.items @items do |item|
  json.title item.variant.product.title_safe
  json.color item.variant.color.title
  json.size @sizes[item.size]
  json.price number_to_rub(item.variant.discount_price(@user.get_discount))
  json.image item.variant.images.first.photo.preview.url
end

json.sum number_to_rub(@items.map{ |i| i.variant.discount_price(@user.get_discount) * i.quantity }.sum)
