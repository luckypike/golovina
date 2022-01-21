json.variants @variants do |variant|
  json.partial! variant

  json.title variant.title_last.squish

  json.images variant.images.active_and_ordered.limit(2).each do |image|
    json.id image.id
    json.thumb image.photo.thumb.url if image.file.attached?
  end
end
