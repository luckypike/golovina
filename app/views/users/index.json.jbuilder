json.users @users.sort_by{ |u| u.orders.not_cart.map(&:amount).sum(&:to_i) }.reverse_each.first(50) do |user|
  json.name user.name
  json.email user.email

  orders = user.orders.not_cart.map(&:amount).sum(&:to_i)

  json.summa orders

  json.quantity user.orders.not_cart.length
end
