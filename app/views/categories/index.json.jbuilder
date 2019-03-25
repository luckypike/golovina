json.categories(@categories) do |category|
  json.extract! category, :id, :title, :state
  json.variants do
    json.active category.variants_counter
    json.total category.variants.size
  end
end
