json.variants @variant.product.variants.active.includes(:color, { availabilities: :size }) do |variant|
  json.partial! 'variants/variant', variant: variant
  json.extract! variant, :desc, :comp

  json.availabilities variant.availabilities do |availability|
    json.extract! availability, :count
    json.active availability.active?
    json.size do
      json.id availability.size.id
      json.title availability.size.size
    end
  end

  json.in_wishlist variant.in_wishlist(Current.user)

  json.color do
    json.extract! variant.color, :id, :title, :image_url, :color
  end
end
