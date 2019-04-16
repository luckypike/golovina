json.variants @variant.product.variants.includes(:color, { availabilities: :size }) do |variant|
  next if variant.archived? && !Current.user&.is_editor?
  json.partial! 'variants/variant', variant: variant
  json.extract! variant, :desc, :comp

  json.availabilities variant.availabilities.group_by(&:size) do |size, availabilities|
    json.size do
      quantity = availabilities.sum(&:quantity)
      json.id size.id
      json.title size.size
      json.weight size.weight
      json.quantity quantity
      json.active quantity > 0
    end

    json.availabilities availabilities do |availability|
      json.extract! availability, :quantity
      json.active availability.active?
      json.store availability.store, :id, :title
    end
  end

  json.in_wishlist variant.in_wishlist(Current.user)

  json.color do
    json.extract! variant.color, :id, :title, :image_url, :color
  end
end
