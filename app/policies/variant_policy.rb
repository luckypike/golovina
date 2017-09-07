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

  def destroy?
    update?
  end

  def wishlist?
    user
  end

  def cart?
    user
  end
end
