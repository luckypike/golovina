json.kits @kits do |kit|
  json.partial! kit
  json.title kit.human_title

  json.variants kit.variants, partial: 'variants/variant', as: :variant
end
