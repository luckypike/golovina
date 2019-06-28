json.kit do
  json.partial! 'kit', kit: @kit

  json.variants @kit.variants.each do |variant|
    json.id variant.id
    json.title "#{variant.product.title} - #{variant.color.title}"
    json.thumb variant.images.first.photo.preview.url if variant.images.size > 0
    json.category variant.product.category_id
  end
end
