json.extract! variant, :id, :price, :price_last, :price_sell, :code, :state, :preorder, :preordered, :quantity, :video_hide

if variant.published_at && variant.published_at.to_datetime.change({ hour: 7, min: 0 }) > Time.now.utc
  json.published_at variant.published_at
end
