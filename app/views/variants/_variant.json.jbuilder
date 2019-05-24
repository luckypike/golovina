json.extract! variant, :id, :price, :price_last, :price_sell, :color_id, :sale, :latest, :soon

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

json.hide variant.images.size < 1 && !Current.user&.is_editor?

json.title variant.product.title.strip
json.image variant.images.limit(2).each do |image|
  json.thumb image.photo.thumb.url if variant.images.size > 0
end

json.colour variant.product.variants.where(state: [:active, :soon]).count - 1
