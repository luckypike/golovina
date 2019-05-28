json.extract! kit, :id, :title

json.images kit.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
  json.id image.id
  json.preview image.photo.preview.url
end
