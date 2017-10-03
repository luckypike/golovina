json.variants @variants do |variant|
  json.id variant.id
  json.title variant.product.title_safe
  json.color variant.color.title
  json.title_full "#{variant.product.title_safe} (#{variant.color.title})"
  json.image variant.images.first.photo.preview.url if variant.images.size > 0
end