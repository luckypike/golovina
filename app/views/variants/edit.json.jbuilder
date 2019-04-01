json.variant do
  json.partial! 'variant', variant: @variant
end

json.colors @colors do |color|
  json.extract! color, :id, :title
end
