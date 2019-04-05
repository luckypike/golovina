json.orders @orders do |order|
  json.extract! order, :id, :amount, :state, :address
end
