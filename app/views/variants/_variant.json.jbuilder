json.extract! variant, :id, :price, :price_last, :price_sell, :color_id, :code, :state

if variant.available?
  json.latest variant.latest || '' unless variant.bestseller || variant.last
  json.sale variant.sale || '' unless variant.last
  json.bestseller variant.bestseller || '' unless variant.last
  json.last variant.last || ''
elsif
  json.sold_out true
end

json.created_at variant.created_at.strftime('%FT%I:%M')
json.can_edit policy(variant).edit?

json.images variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first(2).each do |image|
  json.id image.id
  json.thumb image.photo.thumb.url unless variant.images.empty?
end

json.category do
  json.extract! variant.product.category, :id, :slug
end

json.product do
  json.extract! variant.product, :id, :title
end

json.title variant.title_last.strip
