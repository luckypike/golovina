json.variant do
  json.partial! @variant

  json.title @variant.title_last.squish
  # json.video @variant.video, :filename if @variant.video.attached?
end

json.partial! 'values', variant: @variant
