json.dictionaries do
  json.states(Variant.states.map{ |key, _id| key })

  json.stores Store.all do |store|
    json.partial! store
  end

  json.themes Theme.with_translations.all do |theme|
    json.partial! theme
  end

  json.sizes Size.all do |size|
    json.partial! size
  end

  json.categories Category.with_translations.all.sort_by(&:title) do |category|
    json.partial! category
  end

  json.colors Color.main.with_translations.includes(colors: :translations).sort_by(&:title) do |color|
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

  json.theme_ids variant.themes.pluck(:id)

  # json.latest variant.latest || ''
  # json.sale variant.sale || ''
  # json.bestseller variant.bestseller || ''
  # json.last variant.last || ''
  # json.pinned variant.pinned || ''
  # json.premium variant.premium || ''
  # json.spec variant.spec || false
  # json.linen variant.linen || false
  # json.stayhome variant.stayhome || ''

  json.state variant.state || ''
  json.code variant.code || ''
  json.price variant.price || ''
  json.price_last variant.price_last || ''
  json.color_id variant.color_id || ''
  json.created_at variant.created_at ? variant.created_at.strftime('%FT%H:%M') : ''

  json.product_attributes do
    variant.product.globalize_attribute_names.each do |f|
      json.set! f, variant.product.send(f) || ''
    end

    json.id variant.product.id
    json.category_id variant.product.category_id || ''
  end

  json.availabilities_attributes @variant.availabilities do |availability|
    json.extract! availability, :id, :variant_id, :size_id, :quantity, :store_id
    json.weight availability.size.weight
    # json._destroy false
  end

  json.images_attributes @variant.images.sort_by(&:weight_or_created) do |image|
    json.id image.id
    json.preview image.photo.preview.url
    json.favourite image.favourite
  end
end
