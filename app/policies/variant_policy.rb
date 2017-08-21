class VariantPolicy < ApplicationPolicy
  def create?
    update?
  end

  def update?
    p 'XXX'
    user&.is_editor?
  end
end
