json.items @items.group_by(&:month).sort.reverse_each do |month, month_items|
  json.days month_items.group_by(&:day).sort.reverse_each do |day, day_items|
    json.date day.strftime('%d.%m.%y')

    day_profit = day_items.select { |d| d.class.name == 'Order' }
      .map(&:amount).sum(&:to_i)

    ids = day_items.select { |i| i.class.name == 'Order' }
      .map(&:id)

    json.ids ids

    json.profit day_profit
  end

  json.month month.strftime('%m.%y')

  profit = month_items.select { |p| p.class.name == 'Order' }
    .map(&:amount).sum(&:to_i)

  refund = month_items.select { |r| r.class.name == 'Refund' }
    .map(&:amount).flatten.sum(&:to_i)

  json.profit profit
  json.refund refund
  json.result profit - refund
end
