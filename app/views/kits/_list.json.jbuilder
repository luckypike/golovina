json.array! kits do |kit|
  json.partial! kit
  json.title kit.human_title
  json.price kit.variants.map(&:price_sell).sum

  json.variants kit.variants do |variant|
    next unless variant.active?

    json.state variant.state
  end
end
