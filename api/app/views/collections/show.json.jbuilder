json.collection do
  json.extract! @collection, :id, :title, :text, :desc

  json.images @collection.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
    json.id image.id
    json.collection image.photo.collection.url
    json.width image.width
    json.height image.height
  end
end
