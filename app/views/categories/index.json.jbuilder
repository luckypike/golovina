json.categories(@categories) do |category|
  json.extract! category, :id, :title, :parent_category_id, :variants_count
end
