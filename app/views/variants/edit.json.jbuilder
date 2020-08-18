json.variant do
  json.partial! @variant

  json.title @variant.title_last.squish
end

json.partial! 'values', variant: @variant
