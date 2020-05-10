json.extract! order, :id, :number, :state, :address, :comment, :delivery
# json.gift Order::GIFT if order.gift?
# json.purchasable order.purchasable?
# json.date l(order.payed_at.presence || order.updated_at)
# json.editable Current.user&.is_editor?
