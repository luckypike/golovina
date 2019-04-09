json.collection do
  json.extract! @collection, :id, :title, :text

  json.images @collection.images do |image|
    json.id image.id
    json.collection image.photo.collection.url
    json.width image.width
    json.height image.height
  end
end
