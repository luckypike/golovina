class UserPolicy < ApplicationPolicy
  def orders?
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
