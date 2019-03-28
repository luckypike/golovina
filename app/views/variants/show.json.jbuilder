json.variants @variant.product.variants.active.includes(:color, { availabilities: :size }) do |variant|
  json.partial! 'variants/variant', variant: variant
  json.availabilities variant.availabilities do |availability|
    json.extract! availability, :count
    json.size do
      json.id availability.size.id
      json.title availability.size.size
    end
  end
  json.color do
    json.extract! variant.color, :id, :title, :image_url
  end
end
