json.variant do
  json.partial! @variant

  json.title @variant.title_last.squish if @variant.title
end

json.partial! 'values', variant: @variant
