json.colors @colors.sort_by(&:title) do |color|
  json.partial! 'colors/color', color: color

  json.child_color color.colors.sort_by(&:title) do |color_color|
    json.extract! color_color, :id, :title
    json.variants color_color.variants.active.size if color_color.variants.active.size > 0
  end

  json.variants color.variants.active.size if color.variants.active.size > 0

  json.image color.image
end
