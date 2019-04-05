json.variant do
  json.partial! 'variant', variant: @variant
  json.extract! @variant, :desc, :comp, :sale, :latest, :pinned, :state

  json.product_attributes do
    json.id @variant.product.id
    json.title @variant.product.title
    json.category_id @variant.product.category_id
  end

  json.availabilities_attributes @variant.availabilities do |availability|
    json.extract! availability, :id, :variant_id, :size_id, :count, :store_id
    json._destroy false
  end
end

json.colors @colors do |color|
  json.extract! color, :id, :title
end

json.stores @stores do |store|
  json.extract! store, :id, :title
end

json.sizes @sizes do |size|
  json.extract! size, :id, :size
end
