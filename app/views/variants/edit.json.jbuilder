json.variant do
  json.partial! @variant

#   json.extract! @variant, :desc, :comp, :sale, :latest, :soon, :pinned, :state, :last
#
#   json.images @variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
#     json.id image.id
#     json.preview image.photo.preview.url
#     json.favourite image.favourite
#   end
#
#   json.product_attributes do
#     json.id @variant.product.id
#     json.title @variant.product.title
#     json.category_id @variant.product.category_id
#   end
#
#   json.availabilities_attributes @variant.availabilities do |availability|
#     json.extract! availability, :id, :variant_id, :size_id, :quantity, :store_id
#     json.weight availability.size.weight
#     json._destroy false
#   end
end

json.partial! 'values', variant: @variant
