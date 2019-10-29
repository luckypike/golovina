json.variant do
  json.partial! @variant
end

json.partial! 'values', variant: @variant
