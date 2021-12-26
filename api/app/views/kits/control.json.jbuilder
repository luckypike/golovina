json.kits @kits do |kit|
  json.id kit.id
  json.state kit.state
  json.title kit.human_title
  json.image kit.images.first.photo.thumb.url if kit.images.size > 0
end
