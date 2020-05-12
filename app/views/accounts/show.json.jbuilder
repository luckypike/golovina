json.orders @orders do |order|
  json.partial! order
  json.extract! order, :amount, :quantity

  if order.delivery_city
    json.delivery_city do
      json.partial! order.delivery_city
    end
  end

  # json.user do
  #   json.extract! order.user, :title, :email, :phone
  # end
end
