json.variants do
  json.partial! 'variants/list', variants: @variants.sort_by { |v| [v.product.category.weight, v.weight] }
end
