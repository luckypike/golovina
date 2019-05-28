json.kits @kits do |kit|
  json.id kit.id
  json.title kit.human_title
  json.image kit.images.first.photo.preview.url if kit.images.size > 0
end
