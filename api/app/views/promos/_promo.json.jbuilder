json.extract! promo, :id, :link, :front, :popup

promo.globalize_attribute_names.each do |f|
  json.set! f, promo.send(f) || ''
end
