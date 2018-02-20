json.categories(@categories) do |category|
  json.extract! category, :id, :title, :parent_category_id, :variants_count
  json.archived category.categories.map{|c| c.variants.where(state: [:archived]).size}.sum + category.variants.where(state: [:archived]).size
end
