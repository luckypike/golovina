json.extract! post, :id, :title, :text

json.images post.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
  json.id image.id
  json.preview image.photo.preview.url
  json.thumb image.photo.thumb.url
  json.large image.photo.large.url
end
