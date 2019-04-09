class OrderPolicy < ApplicationPolicy
  def index?
    user&.is_editor?
  end

  def create?
    user
  end

  def paid?
    true
  end

  def pay?
    record.user == user && record.purchasable?
  end

  def archive?
    user&.is_editor? && record.can_archive?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
