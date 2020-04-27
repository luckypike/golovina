json.extract! order, :id, :number, :amount, :state, :address, :comment, :quantity, :delivery, :phone
json.gift Order::GIFT if order.gift?
json.purchasable order.purchasable?
json.date l(order.payed_at.presence || order.updated_at)
json.editable Current.user&.is_editor?
