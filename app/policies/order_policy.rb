class OrderPolicy < ApplicationPolicy
  def index?
    user&.is_editor?
  end

  def checkout?
    record.user == user
  end

  def paid?
    true
  end

  def pay?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
