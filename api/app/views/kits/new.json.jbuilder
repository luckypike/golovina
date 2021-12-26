json.kit do
  json.partial! @kit

  json.variants []
end

json.partial! 'values', kit: @kit
