json.variant do
  json.partial! 'variant', variant: @variant
  json.extract! @variant, :desc, :comp, :sale, :latest, :soon, :pinned, :state

  json.product_attributes do
    json.id @variant.product.id
    json.title @variant.product.title
    json.category_id @variant.product.category_id
  end

  json.availabilities_attributes @variant.availabilities do |availability|
    json.extract! availability, :id, :variant_id, :size_id, :quantity, :store_id
    json.weight availability.size.weight
    json._destroy false
  end
end
