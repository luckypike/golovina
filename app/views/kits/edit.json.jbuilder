json.kit do
  json.partial! 'kit', kit: @kit

  json.variants @kit.variants.each do |variant|
    json.id variant.id
    json.title "#{variant.title_last} - #{variant.color.title}"
    json.thumb variant.images.first.photo.preview.url if variant.images.size.positive?
    json.category variant.product.category_id
  end
end

json.partial! 'values', kit: @kit
