json.extract! order, :id, :number, :amount, :state, :address, :quantity, :delivery
json.purchasable order.purchasable?
json.date l(order.payed_at.presence || order.updated_at)
json.editable Current.user&.is_editor?
