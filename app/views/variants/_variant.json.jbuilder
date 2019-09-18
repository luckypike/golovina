json.extract! variant, :id, :price, :price_last, :price_sell, :color_id, :sale, :latest, :code, :state
json.created_at variant.created_at.strftime('%FT%I:%M')
json.can_edit policy(variant).edit?

json.images variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first(2).each do |image|
  json.id image.id
  json.thumb image.photo.thumb.url + '?v=1.1' if variant.images.size > 0
end

json.category do
  json.extract! variant.product.category, :id, :slug
end

json.product do
  json.extract! variant.product, :id, :title
end

# json.hide variant.images.size < 1 && !Current.user&.is_editor?

json.title variant.product.title.strip


# json.colour variant.product.variants.reject(&:archived?).size - 1
