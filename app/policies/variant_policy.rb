class VariantPolicy < ApplicationPolicy
  def create?
    update?
  end

  def update?
    user&.is_editor?
  end
end
