json.values do
  color.globalize_attribute_names.each do |f|
    json.set! f, color.send(f) || ''
  end

  json.color color.color || ''
  json.parent_color_id color.parent_color_id || ''
end

json.dictionaries do
  json.colors Color.main.sort_by(&:title) do |color|
    json.partial! color
  end
end
