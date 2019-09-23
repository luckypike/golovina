json.extract! order, :id, :number, :amount, :state, :address, :quantity, :delivery
json.purchasable order.purchasable?
json.created_at l(order.created_at.to_date)
json.editable Current.user&.is_editor?
