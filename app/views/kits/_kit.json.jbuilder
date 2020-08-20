json.extract! kit, :id, :state

# kit.globalize_attribute_names.each do |f|
#   json.set! f, kit.send(f) || ''
# end

json.images kit.video.present? ? nil : kit.images.sort_by(&:weight_or_created).first(1) do |image|
  json.id image.id
  json.thumb image.photo.thumb.url
  json.preview image.photo.preview.url
end
