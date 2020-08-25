json.items @items do |item|
  json.partial! item

  json.type item.class.name
  json.title item.title_last.squish

  json.images item.images.sort_by(&:weight_or_created).first(1).each do |image|
    json.id image.id
    json.thumb image.photo.thumb.url
  end
end
