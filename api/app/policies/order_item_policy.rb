class OrderItemPolicy < ApplicationPolicy
  def destroy?
    user && record.order.user == user
  end
end
