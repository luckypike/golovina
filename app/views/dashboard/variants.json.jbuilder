json.variants @variants do |variant|
  json.partial! variant

  json.title variant.title_last.squish

  json.images variant.images.sort_by(&:weight_or_created).first(2).each do |image|
    json.id image.id
    json.thumb image.photo.thumb.url
  end
end
