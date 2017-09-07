json.items @items do |item|
  json.title item.variant.product.title_safe
  json.color item.variant.color.title
  json.size item.size
  json.price number_to_rub(item.variant.product.price)
end

json.sum number_to_rub(@items.map{ |i| i.variant.product.price }.sum)