json.orders @orders do |order|
  json.partial! 'orders/order', order: order
  json.items order.order_items do |item|
    json.extract! item, :id, :quantity

    json.variant do
      json.partial! item.variant

      json.title item.variant.title_last.squish

      json.images item.variant.images.sort_by(&:weight_or_created).first(2).each do |image|
        json.id image.id
        json.thumb image.photo.thumb.url
      end
    end

    json.price_sell item.price_sell
    json.color item.variant.color, partial: 'colors/color', as: :color
    json.size item.size, partial: 'sizes/size', as: :size
    json.refund item.refund.present?
  end
end
