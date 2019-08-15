json.extract! refund, :id, :state, :quantity, :amount, :order_id, :reason, :detail
json.address refund.order.address
json.created_at l(refund.created_at.to_date)
json.editable Current.user&.is_admin?
