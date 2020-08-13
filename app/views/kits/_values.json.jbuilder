json.dictionaries do
  json.categories Category.with_translations.all.sort_by(&:title) do |category|
    json.partial! category
  end
end

json.values do
  json.extract! kit, :state

  kit.globalize_attribute_names.each do |f|
    json.set! f, kit.send(f) || ''
  end

  json.category_id kit.category_id

  json.variant_ids kit.variants.pluck(:id)

  json.images_attributes kit.images.sort_by(&:weight_or_created) do |image|
    json.id image.id
    json.preview image.photo.preview.url
    json.favourite image.favourite
  end

  json.category_id kit.category_id || ''

  json.video kit.video.signed_id if kit.video.attached?
end
