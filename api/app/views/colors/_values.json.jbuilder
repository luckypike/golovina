# frozen_string_literal: true

json.values do
  json.title_ru color.title_ru || ""
  json.title_en color.title_en || ""
  json.color color.color || ""
  json.parent_color_id color.parent_color_id || ""
end

json.dictionaries do
  json.colors Color.main.sort_by(&:title) do |color|
    json.partial! color
  end
end
