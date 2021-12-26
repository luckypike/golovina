json.colors @colors.sort_by(&:title) do |color|
  json.partial! 'colors/color', color: color

  json.child_color color.colors.sort_by(&:title) do |color_color|
    json.extract! color_color, :id, :title
    json.variants color_color.variants.active.size if color_color.variants.active.size > 0
    json.translated color_color.translations.size == I18n.available_locales.size
  end

  json.variants color.variants.active.size if color.variants.active.size > 0

  json.image color.image

  json.translated color.translations.size == I18n.available_locales.size
end
