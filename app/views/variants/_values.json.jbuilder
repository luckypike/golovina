json.dictionaries do
  json.categories Category.with_translations.all.sort_by(&:title) do |category|
    json.partial! category
  end

  json.colors Color.main.includes(:colors).sort_by(&:title) do |color|
    json.partial! color

    json.colors color.colors.sort_by(&:title) do |child_color|
      json.partial! child_color
    end
  end
end

json.values do
  variant.globalize_attribute_names.each do |f|
    json.set! f, variant.send(f) || ''
  end

  json.code variant.code || ''
  json.price variant.price || ''
  json.price_last variant.price_last || ''
  json.color_id variant.color_id || ''
  json.created_at variant.created_at ? variant.created_at.strftime('%FT%H:%M') : ''

  json.product_attributes do
    variant.product.globalize_attribute_names.each do |f|
      json.set! f, variant.product.send(f) || ''
    end

    json.category_id variant.product.category_id || ''
  end
end
