json.variants @variant.product.variants.active.includes(:color, { availabilities: :size }) do |variant|
  json.partial! 'variants/variant', variant: variant
  json.extract! variant, :desc, :comp

  json.availabilities variant.availabilities.group_by(&:size) do |size, availabilities|
    json.size do
      count = availabilities.sum(&:count)
      json.id size.id
      json.title size.size
      json.count count
      json.active count > 0
    end

    json.availabilities availabilities do |availability|
      json.extract! availability, :count
      json.active availability.active?
      json.store availability.store, :id, :title
    end
  end

  json.in_wishlist variant.in_wishlist(Current.user)

  json.color do
    json.extract! variant.color, :id, :title, :image_url, :color
  end
end
