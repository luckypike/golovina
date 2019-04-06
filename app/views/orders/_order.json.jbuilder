json.extract! order, :id, :number, :amount, :state, :address, :quantity
json.created_at l(order.created_at.to_date)
