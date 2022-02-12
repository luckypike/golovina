json.array! variants do |variant|
  json.partial! variant
  json.extract! variant, :label
  json.available variant.available?

  json.title variant.title_last.squish

  json.images variant.images.active_and_ordered.limit(variant.single ? 1 : 2).each do |image|
    json.id image.id
    json.thumb image.thumb_url if image.file.attached?
  end

  if variant.video_mp4.attached?
    json.video variant.video_mp4.key
  end

  json.category do
    json.extract! variant.category, :id, :slug
  end

  json.colors variant.product.variants.select(&:active?).size - 1

  if current_user
    json.in_wishlist(current_user.wishlists.detect { |w| w.variant_id == variant.id }.present?)
  end
end
