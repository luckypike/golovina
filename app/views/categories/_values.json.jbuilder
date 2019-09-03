json.values do
  category.globalize_attribute_names.each do |f|
    json.set! f, category.send(f) || ''
  end

  # json.weight slide.weight || Slide.order(weight: :desc).first.weight + 1
  json.slug category.slug || ''
end
