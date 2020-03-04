json.variants @records.each_with_hit do |record, hit|
  json.partial! record
end
