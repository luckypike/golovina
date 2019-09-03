json.category do
  json.partial! @category
end

json.partial! 'values', category: @category
