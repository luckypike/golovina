json.values do
  json.title color.title || ''
  json.color color.color || ''
  json.parent_color_id color.parent_color_id || ''

  json.child_color color.colors do |color_color|
    json.extract! color_color, :id, :title
  end
end
