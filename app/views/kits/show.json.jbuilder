json.kit do
  json.partial! @kit
  # json.title kit.human_title

  json.variants @kit.variants do |variant|
    next unless variant.active?

    json.partial! variant

    json.available variant.available?

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
