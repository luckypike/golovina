json.variants @variants do |variant|
  json.partial! variant
  json.extract! variant, :label, :desc, :comp
  json.available variant.available?
  json.preorder variant.preorder?

  json.title variant.title_last.squish

  json.images variant.images.order(weight: :asc).each do |image|
    json.id image.id

    if image.file.attached?
      json.thumb image.thumb_url
      json.large image.large_url
    end
  end

  json.color do
    json.partial! variant.color
  end

  json.product do
    json.partial! variant.product
  end

  json.category do
    json.extract! variant.category, :id, :slug
  end

  json.availabilities(variant.availabilities.sort_by { |a| a.size.weight }) do |availability|
    json.partial! availability
    json.active availability.active?

    json.size do
      json.partial! availability.size
    end
  end

  if variant.kits.active.present?
    json.kits variant.kits.active do |kit|
      json.id kit.id
      json.title kit.title.present? ? kit.human_title : kit.human_title.truncate(60)
      json.image kit.images.present? ? kit.images.sort_by(&:weight).first.photo.thumb.url : nil
      json.items kit.variants.active.size
    end
  end

  json.can_edit policy(variant).edit?

  if current_user
    json.in_wishlist(current_user.wishlists.detect { |w| w.variant_id == variant.id }.present?)
  end

  if variant.video_mp4.attached?
    json.video variant.video_mp4.key
  end
end

# json.variants @variants do |variant|
#   json.partial! 'variants/variant', variant: variant
#   json.extract! variant, :desc, :comp
#   json.available variant.available?
#
#   json.images variant.images.sort_by(&:weight_or_created) do |image|
#     json.id image.id
#     json.preview image.photo.preview.url
#     json.thumb image.photo.thumb.url
#     json.large image.photo.large.url
#   end
#
#   json.availabilities variant.availabilities.group_by(&:size) do |size, availabilities|
#     json.size do
#       quantity = availabilities.sum(&:quantity)
#       json.id size.id
#       json.title size.size
#       json.weight size.weight
#       json.quantity quantity
#       json.active quantity > 0
#     end
#
#     json.availabilities availabilities do |availability|
#       json.extract! availability, :quantity
#       json.active availability.active?
#       json.store availability.store, :id, :title
#     end
#   end
#
#   json.in_wishlist variant.in_wishlist(Current.user)
#
#   json.notification variant.in_notification(Current.user)
#
#   json.color do
#     json.extract! variant.color, :id, :title, :image_url, :color
#   end
#
#   if variant.kits.active.present?
#     json.kits variant.kits.active do |kit|
#       json.id kit.id
#       json.title kit.title.present? ? kit.human_title : kit.human_title.truncate(60)
#       json.image kit.images.present? ? kit.images.sort_by(&:weight).first.photo.thumb.url : nil
#       json.items kit.variants.size
#     end
#   end
# end

# json.archived @variant.product.variants.archived.includes(:color).sort_by(&:state) do |variant|
#   json.id variant.id
#   json.color variant.color.title
#   json.image variant.images.present? ? variant.images.first.photo.thumb.url : nil
# end if Current.user&.is_editor?
