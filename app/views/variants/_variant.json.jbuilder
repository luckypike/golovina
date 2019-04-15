json.extract! variant, :id, :price, :price_last, :price_sell, :color_id, :sale, :latest

json.can_edit policy(variant).edit?

json.category do
  json.extract! variant.product.category, :id, :title, :slug
end

json.product do
  json.extract! variant.product, :id, :title
end

json.images variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
  json.id image.id
  json.preview image.photo.preview.url
  json.thumb image.photo.thumb.url
  json.large image.photo.large.url
end

json.title variant.product.title.strip
json.image variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first.photo.thumb.url if variant.images.size > 0
