json.variant do
  json.partial! 'variants/variant', variant: @variant
  json.sizes @variant.sizes
  json.color do
    json.extract! @variant.color, :id, :title
  end
end

json.variants @variant.product.variants.active.includes(:color) do |variant|
  json.partial! 'variants/variant', variant: variant
  json.color do
    json.extract! variant.color, :id, :title, :image_url
  end
end
