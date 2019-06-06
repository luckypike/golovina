json.extract! variant, :id, :price, :price_last, :price_sell, :color_id, :sale, :latest, :soon, :code
json.updated_at variant.updated_at.strftime('%FT%T')
json.can_edit policy(variant).edit?

json.category do
  json.extract! variant.product.category, :id, :title, :slug
end

json.product do
  json.extract! variant.product, :id, :title
end

json.hide variant.images.size < 1 && !Current.user&.is_editor?

json.title variant.product.title.strip

json.colour variant.product.variants.where(state: [:active, :soon]).count - 1
