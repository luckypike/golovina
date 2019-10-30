json.variants @variants do |variant|
  json.cache! variant, expires_in: 10.minutes do
    json.partial! 'variants/variant', variant: variant

    json.colors variant.product.variants.reject(&:archived?).size - 1
  end
end
