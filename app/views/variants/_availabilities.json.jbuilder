json.array! availabilities.group_by(&:size) do |size, availabilities|
  json.size do
    quantity = availabilities.sum(&:quantity)
    json.id size.id
    json.title size.size
    json.weight size.weight
    json.quantity quantity
    json.active quantity.positive?
  end

  json.availabilities availabilities do |availability|
    json.extract! availability, :quantity
    json.active availability.active?
    json.store availability.store, :id, :title
  end
end
