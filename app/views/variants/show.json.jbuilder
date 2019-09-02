json.variants @variant.product.variants.includes(:color, { availabilities: :size }).sort_by(&:state).select { |v| !v.archived? } do |variant|
  json.partial! 'variants/variant', variant: variant
  json.extract! variant, :desc, :comp
  json.soon variant.availabilities.all? { |availability| availability.quantity < 1} && variant.soon
  json.archived variant.archived?

  json.images variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
    json.id image.id
    json.preview image.photo.preview.url
    json.thumb image.photo.thumb.url
    json.large image.photo.large.url
  end

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

  json.notification variant.in_notification(Current.user)

  json.color do
    json.extract! variant.color, :id, :title, :image_url, :color
  end

  if variant.kits.active.present?
    json.kits variant.kits.active do |kit|
      json.id kit.id
      json.title kit.title.present? ? kit.human_title : kit.human_title.truncate(60)
      json.image kit.images.present? ? kit.images.sort_by(&:weight).first.photo.thumb.url : nil
    end
  end
end

json.archived @variant.product.variants.archived.includes(:color).sort_by(&:state) do |variant|
  json.id variant.id
  json.color variant.color.title
  json.image variant.images.present? ? variant.images.first.photo.thumb.url : nil
end if Current.user&.is_editor?
