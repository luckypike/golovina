json.kits @kits do |kit|
  json.partial! kit
  json.title kit.human_title

  json.variants kit.variants do |variant|
    next unless variant.active?

    json.partial! variant

    json.availabilities do
      json.partial! 'variants/availabilities', availabilities: variant.availabilities
    end
  end
end
