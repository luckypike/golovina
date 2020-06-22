json.items @items do |item|
  json.partial! item
  json.type item.class.name
end
