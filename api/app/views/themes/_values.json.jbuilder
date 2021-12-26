json.dictionaries do
  json.states(Theme.states.map { |key, _id| key })
end

json.values do
  theme.globalize_attribute_names.each do |f|
    json.set! f, theme.send(f) || ''
  end

  # json.weight slide.weight || Slide.order(weight: :desc).first.weight + 1
  json.slug theme.slug || ''

  json.state theme.state
end
