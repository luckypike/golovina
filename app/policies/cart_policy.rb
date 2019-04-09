class CartPolicy < ApplicationPolicy
  def index?
    user
  end

  def destroy?
    record.user == user
  end
end
