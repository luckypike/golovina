json.variants @records.each_with_hit do |variant, _hit|
  next unless variant.active?

  json.partial! variant
  json.extract! variant, :label
  json.available variant.available?

  json.title variant.title_last.squish

  json.images variant.images.order(weight: :asc).limit(2).each do |image|
    json.id image.id
    json.thumb image.thumb_url
  end

  json.category do
    json.extract! variant.category, :id, :slug
  end

  json.colors variant.product.variants.select(&:active?).size - 1
end
