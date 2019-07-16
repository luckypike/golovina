json.extract! kit, :id, :title, :state

json.images(kit.images.sort_by(&:weight_or_created)) do |image|
  json.id image.id
  json.thumb image.photo.thumb.url
end
