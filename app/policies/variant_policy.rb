class VariantPolicy < ApplicationPolicy
  def images?
    true
  end

  def create?
    update?
  end

  def update?
    user&.is_editor?
  end
end
