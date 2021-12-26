json.slide do
  json.partial! @slide
end

json.partial! 'values', slide: @slide
