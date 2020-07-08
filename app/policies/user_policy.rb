class UserPolicy < ApplicationPolicy
  def index?
    user&.is_editor?
  end

  def orders?
    user == record
  end

  def refunds?
    user == record
  end

  def account?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
