json.colors @colors do |color|
  json.partial! 'colors/color', color: color

  json.child_color color.colors do |color_color|
    json.extract! color_color, :id, :title
  end

  json.image color.image
end
