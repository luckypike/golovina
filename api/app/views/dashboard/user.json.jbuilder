json.orders @orders do |order|
  json.partial! order
  json.extract! order, :amount, :quantity
  json.amount order.amount.presence || order.amount_calc

  if order.delivery_city
    json.delivery_city do
      json.partial! order.delivery_city
    end
  end

  json.items order.items do |item|
    json.partial! item

    json.variant do
      json.partial! item.variant
      json.available item.variant.available?

      json.title item.variant.title_last.squish

      json.images item.variant.images.active_and_ordered.each do |image|
        json.id image.id
        json.thumb image.thumb_url if image.file.attached?
      end

      if item.variant.category
        json.category do
          json.extract! item.variant.category, :id, :slug
        end
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

json.refunds @refunds do |refund|
  json.partial! refund
end
