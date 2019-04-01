json.extract! kit, :id, :title

json.images kit.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
  json.thumb image.photo.thumb.url
  json.large image.photo.large.url
end
