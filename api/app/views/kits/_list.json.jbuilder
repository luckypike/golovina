json.array! kits do |kit|
  json.partial! kit
  json.title kit.human_title
  json.price kit.variants.map(&:price_sell).sum

  json.images kit.images.sort_by(&:weight_or_created) do |image|
    json.id image.id
    json.thumb image.photo.thumb.url
    json.preview image.photo.preview.url
  end

  if kit.video_mp4.attached?
    json.video kit.video_mp4.key
    json.video_poster kit.video_poster.key if kit.video_poster.present?
  end

  json.variants kit.variants do |variant|
    next unless variant.active?

    json.state variant.state
  end
end
