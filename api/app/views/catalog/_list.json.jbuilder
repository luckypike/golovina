json.array! items do |item|
  json.partial! item
  json.type item.class.name
  json.title item.title_last.squish
  json.video item.video_mp4.key if item.video_mp4.attached?
  json.poster item.video_poster.key if item.video_poster.attached?

  json.category do
    json.extract! item.category, :id, :slug
  end

  if item.is_a?(Kit)
    json.extract! item, :price_sell

    json.images item.images.sort_by(&:weight_or_created).each do |image|
      json.id image.id
      json.thumb image.photo.thumb.url
    end

    json.variants item.variants do |variant|
      next unless variant.active?

      json.state variant.state
    end
  elsif item.is_a?(Variant)
    json.extract! item, :label
    json.available item.available?
    json.colors item.product.variants.select(&:active?).size - 1

    json.images item.images.active_and_ordered.limit(2).each do |image|
      json.id image.id
      json.thumb image.thumb_url if image.file.attached?
    end

    current_user && json.in_wishlist(current_user.wishlists.detect { |w| w.variant_id == item.id }.present?)
  end
end
