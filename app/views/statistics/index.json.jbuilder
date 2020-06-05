json.items @items.group_by(&:month).sort.reverse_each do |month, month_items|
  json.month month.strftime('%m.%y')
  profit = month_items.select { |p| p.class.name == 'Order' }
    .map(&:amount).sum(&:to_i)

  refund = month_items.select { |r| r.class.name == 'Refund' }
    .map(&:amount).flatten.sum(&:to_i)

  json.profit profit
  json.refund refund
  json.result profit - refund
end
