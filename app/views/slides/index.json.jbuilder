json.slides @slides do |slide|
  json.partial! slide
  json.weight slide.weight
end
