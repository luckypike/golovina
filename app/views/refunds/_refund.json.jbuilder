json.extract! refund, :id, :state, :quantity, :amount, :order_id, :reason, :detail

json.user do
  json.partial! refund.user
end

json.items refund.order_items do |item|
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

json.created_at l(refund.created_at.to_date)
json.editable Current.user&.is_editor?
