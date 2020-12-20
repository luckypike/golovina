class OrderPolicy < ApplicationPolicy
  def cart?
    true
  end

  def checkout?
    user == record.user
  end

  def pay?
    user == record.user
  end

  def cert?
    user == record.user
  end

  def index?
    user&.editor?
  end

  def paid?
    true
  end

  def archive?
    user&.editor?
  end

  def unarchive?
    archive?
  end

  def delivery?
    user&.editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
