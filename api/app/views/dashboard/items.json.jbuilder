json.items @items do |item|
  json.partial! item

  json.type item.class.name
  json.title item.title_last.squish

  if item.is_a?(Kit)
    json.images item.images.sort_by(&:weight_or_created).first(1).each do |image|
      json.id image.id
      json.thumb image.photo.thumb.url
    end
  elsif item.is_a?(Variant)
    json.images item.images.active_and_ordered.limit(1).each do |image|
      json.id image.id
      json.thumb image.thumb_url if image.file.attached?
    end
  end
end
