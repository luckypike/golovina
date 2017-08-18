class VariantPolicy < ApplicationPolicy
  def create?
    update?
  end

  def update?
    user.if_editor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
