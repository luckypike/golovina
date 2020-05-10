class OrderPolicy < ApplicationPolicy
  def cart?
    true
  end

  def checkout?
    user == record.user
  end

  def index?
    user&.editor?
  end

  def paid?
    true
  end

  def archive?
    user&.editor? && record.can_archive?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
