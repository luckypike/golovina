json.extract! variant, :id, :price, :price_last
json.title variant.product.title.strip
json.image variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first.photo.thumb.url if variant.images.size > 0
