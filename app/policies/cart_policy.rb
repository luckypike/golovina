class CartPolicy < ApplicationPolicy
  def show?
    user
  end
end
