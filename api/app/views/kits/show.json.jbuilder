json.kit do
  json.partial! @kit
  # json.title kit.human_title

  json.images @kit.images.sort_by(&:weight_or_created) do |image|
    json.id image.id
    json.thumb image.photo.thumb.url
    json.preview image.photo.preview.url
  end

  if @kit.video_mp4.attached?
    json.video @kit.video_mp4.key
    json.video_poster @kit.video_poster.key if @kit.video_poster.present?
  end

  json.variants @kit.variants do |variant|
    next unless variant.active?

    json.partial! variant
    json.extract! variant, :label

    json.available variant.available?
    json.preorder variant.preorder?

    json.title variant.title_last.squish

    json.images variant.images.sort_by(&:weight_or_created).first(2).each do |image|
      json.id image.id
      json.thumb image.photo.thumb.url
    end

    json.category do
      json.extract! variant.product.category, :id, :slug
    end

    json.product do
      json.partial! variant.product
    end

    json.category do
      json.extract! variant.product.category, :id, :slug
    end

    json.availabilities(variant.availabilities.sort_by { |a| a.size.weight }) do |availability|
      json.partial! availability
      json.active availability.active?

      json.size do
        json.partial! availability.size
      end
    end
  end
end
