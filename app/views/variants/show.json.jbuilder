json.variants @variant.product.variants.active.includes(:color) do |variant|
  json.partial! 'variants/variant', variant: variant
  json.sizes @sizes.map{ |size| { id: size.id, title: size.size, count: variant.sizes[size.id.to_s]  } }
  json.color do
    json.extract! variant.color, :id, :title, :image_url
  end
end
