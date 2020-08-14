json.kits do
  json.partial! 'kits/list', kits: @kits
end

json.variants do
  json.partial! 'variants/list', variants: @variants
end
