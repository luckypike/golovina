json.array! kits do |kit|
  json.partial! kit
  json.title kit.human_title
  json.price kit.variants.map(&:price_sell).sum

  if kit.video_mp4.attached?
    json.video kit.video_mp4.key
    json.video_poster kit.video_poster.key
  end

  json.variants kit.variants do |variant|
    next unless variant.active?

    json.state variant.state
  end
end
