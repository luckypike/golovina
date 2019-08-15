class RefundPolicy < ApplicationPolicy
  def refund?
    user
  end

  def index?
    user&.is_admin?
  end

  def create?
    user
  end

  def done?
    user&.is_admin?
  end
end
