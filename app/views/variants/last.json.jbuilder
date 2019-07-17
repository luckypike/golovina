json.variants @variants do |variant|
  json.partial! 'variants/variant', variant: variant

  json.colors variant.product.variants.reject(&:archived?).size - 1
end
