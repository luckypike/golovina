json.items do
  json.partial! 'catalog/list', items: (@variants + @kits).sort_by(&:weight)
end
