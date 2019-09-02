json.values do
  json.title color.title || ''
  json.color color.color || ''
  json.parent_color_id color.parent_color_id || ''
  json.image do
    json.url color.image.url
  end
end
