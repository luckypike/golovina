json.extract! color, :id, :title, :color, :parent_color_id, :image_url

if color.main?
  json.colors color.colors do |child_color|
    json.partial! child_color
  end
end
