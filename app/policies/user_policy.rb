class UserPolicy < ApplicationPolicy
  def orders?
    user == record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
