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

    json.images item.variant.images.active_and_ordered.each do |image|
      json.id image.id
      json.thumb image.photo.thumb.url if image.file.attached?
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

json.created_at l(refund.created_at.to_date)
json.editable Current.user&.is_editor?
