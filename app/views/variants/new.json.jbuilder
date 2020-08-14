json.variant do
  json.partial! @variant

  json.title @variant.title_last.squish if @variant.title
  # json.video @variant.video, :filename if @variant.video.attached?
end

json.partial! 'values', variant: @variant
