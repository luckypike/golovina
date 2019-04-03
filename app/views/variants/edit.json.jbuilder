json.variant do
  json.partial! 'variant', variant: @variant
end

json.colors @colors do |color|
  json.extract! color, :id, :title
end

json.stores @stores do |store|
  json.extract! store, :id, :title
end

json.sizes @sizes do |size|
  json.extract! size, :id, :size
end
