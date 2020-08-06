# json.slide @slide, partial: 'slides/slide', as: :slide
json.partial! 'slides/values', slide: @slide

json.slide do
  json.partial! @slide

  json.video @slide.video, :filename if @slide.video.attached?
end
