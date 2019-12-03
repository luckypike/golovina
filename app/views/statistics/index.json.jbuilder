json.items @items.group_by(&:month).sort.reverse_each do |month, month_items|
  json.month month.strftime('%m.%y')
  profit = month_items.select{ |profit| profit.class.name == "Order" }.map{ |i| i.amount_without_delivery }.sum.round
  refund = month_items.select{ |refund| refund.class.name == "Refund" }.map{ |i| i.order_items.map(&:price) }.flatten.sum.round

  json.profit profit
  json.refund refund
  json.result profit - refund
end
