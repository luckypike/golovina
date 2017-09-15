class OrderPolicy < ApplicationPolicy
  def checkout?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
