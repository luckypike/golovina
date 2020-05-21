json.array! @orders do |order|
  json.partial! order
  json.extract! order, :quantity, :updated_at
  json.amount order.amount.presence || order.amount_calc

  if order.delivery_city
    json.delivery_city do
      json.partial! order.delivery_city
    end
  end

  json.user do
    json.partial! order.user
  end

  json.items order.items do |item|
    json.partial! item

    json.variant do
      json.partial! item.variant
      json.available item.variant.available?

      json.title item.variant.title_last.squish

      json.images item.variant.images.sort_by(&:weight_or_created).each do |image|
        json.id image.id
        json.thumb image.photo.thumb.url
      end

      json.category do
        json.extract! item.variant.product.category, :id, :slug
      end

      json.color do
        json.partial! item.variant.color
      end
    end

    if item.size
      json.size do
        json.partial! item.size
      end
    end
  end
end
