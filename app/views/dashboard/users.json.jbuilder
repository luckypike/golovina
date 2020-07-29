json.users @users.sort_by{ |u| u.orders.reject(&:cart?).map(&:amount).sum(&:to_i) }.reverse_each.first(50) do |user|
  json.id user.id
  json.title user.title
  json.email user.email

  orders = user.orders.reject(&:cart?).map(&:amount).sum(&:to_i)

  json.summa orders

  json.quantity user.orders.reject(&:cart?).size

  json.orders user.orders.reject(&:cart?) do |order|
    json.partial! order
  end
end

json.all @users do |user|
  json.partial! user
end
