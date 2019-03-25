json.categories(@categories) do |category|
  json.extract! category, :id, :title
  json.variants category.variants.size
end
