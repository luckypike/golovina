class RefundPolicy < ApplicationPolicy
  def refund?
    user
  end

  def index?
    user&.is_editor?
  end

  def create?
    user
  end

  def done?
    user&.is_editor?
  end
end
