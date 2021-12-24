json.slides @slides do |slide|
  json.partial! slide
  json.weight slide.weight
  json.image slide.image.preview.url
end
