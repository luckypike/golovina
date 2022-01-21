json.wishlists @wishlists.group_by(&:user) do |user, user_wishlists|
  json.user do
    json.partial! user
  end

  json.wishlists user_wishlists do |wishlist|
    json.partial! wishlist

    json.variant do
      json.partial! wishlist.variant

      json.title wishlist.variant.title_last.squish

      json.images wishlist.variant.images.active_and_ordered.each do |image|
        json.id image.id
        json.thumb image.thumb_url if image.file.attached?
      end

      if wishlist.variant.category
        json.category do
          json.extract! wishlist.variant.category, :id, :slug
        end
      end

      json.color do
        json.partial! wishlist.variant.color
      end
    end
  end
end
