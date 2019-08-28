json.slide @slide, partial: 'slides/slide', as: :slide
json.partial! 'slides/values', slide: @slide
