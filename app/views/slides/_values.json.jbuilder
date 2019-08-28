json.values do
  slide.globalize_attribute_names.each do |f|
    json.set! f, slide.send(f) || ''
  end

  json.weight slide.weight || Slide.order(weight: :desc).first.weight + 1
  json.link slide.link || ''

  # json.translations slide.translations do |translation|
  #   json.locale translation.locale
  #   json.name translation.name
  # end

  # json.translations I18n.available_locales do |locale|
  #   translation = slide.translations.find_or_initialize_by(locale: locale)
  #   json.locale translation.locale
  #   json.name translation.name || ''
  # end
end
