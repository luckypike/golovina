json.extract! order, :id, :number, :state, :comment, :payed_at,
  :delivery, :delivery_option,
  :tracker_type, :tracker_id, :tracker_url,
  :address_old, :country, :city, :zip, :street, :house, :appartment, :delivery_city_id
# json.gift Order::GIFT if order.gift?
# json.purchasable order.purchasable?
# json.date l(order.payed_at.presence || order.updated_at)
# json.editable Current.user&.is_editor?
