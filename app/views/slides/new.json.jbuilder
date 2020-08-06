json.slide do
  json.partial! @slide

  json.video @slide.video, :filename if @slide.video.attached?
end

json.partial! 'slides/values', slide: @slide
