json.kit do
  json.partial! 'kit', kit: @kit

  json.variants @kit.variants.each do |variant|
    json.id variant.id
    json.title "#{variant.title_last} - #{variant.color.title}"
    json.thumb variant.images.active_and_ordered.first.thumb_url if variant.images.active_and_ordered.size > 0
    json.category variant.product.category_id
  end
end

json.partial! 'values', kit: @kit
