class PromoPolicy < ApplicationPolicy
  def index?
    user&.is_editor?
  end

  def last?
    true
  end

  def update?
    user&.is_editor?
  end

  def create?
    update?
  end

  def destroy?
    create?
  end
end
