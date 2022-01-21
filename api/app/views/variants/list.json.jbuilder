json.categories @variants.group_by{|v| v.product.category}.each do |category, variants|
  json.id category.id
  json.title category.title
  json.active false
  json.variants variants.each do |variant|
    json.id variant.id
    json.title "#{variant.title_last} - #{variant.color.title}"
    json.thumb variant.images.active_and_ordered.first.thumb_url if variant.images.active_and_ordered.size > 0
    json.category variant.product.category_id
  end
end
