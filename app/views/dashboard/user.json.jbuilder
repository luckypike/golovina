json.user do
  json.partial! @user

  json.orders @user.orders
  json.refunds @user.refunds
end
