json.variants @variants do |variant|
  json.id variant.id
  json.state variant.state
  json.title variant.title_last
  json.color variant.color.title
  json.title_full "#{variant.title_last} (#{variant.color.title})"
  json.image variant.images.first.photo.preview.url if variant.images.size > 0
end

json.selected @selected do |variant|
  json.id variant.id
  json.title variant.title_last
  json.color variant.color.title
  json.title_full "#{variant.title_last} (#{variant.color.title})"
  json.image variant.images.first.photo.preview.url if variant.images.size > 0
end
