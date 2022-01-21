json.variants do
  json.array! @variants do |variant|
    json.partial! variant
    json.extract! variant, :label
    json.available variant.available?

    json.title variant.title_last.squish

    json.images variant.images.active_and_ordered.limit(1).each do |image|
      json.id image.id
      json.thumb image.thumb_url if image.file.attached?
    end

    json.category do
      json.extract! variant.category, :id, :slug
    end

    if current_user
      json.in_wishlist(current_user.wishlists.detect { |w| w.variant_id == variant.id }.present?)
    end

    json.availabilities(variant.availabilities.sort_by { |a| a.size.weight }) do |availability|
      json.partial! availability
      json.active availability.active?

      json.size do
        json.partial! availability.size
      end
    end
  end
end
