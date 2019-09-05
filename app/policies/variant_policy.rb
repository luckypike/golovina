class VariantPolicy < ApplicationPolicy
  def list?
    index?
  end

  def images?
    true
  end

  def all?
    true
  end

  def latest?
    all?
  end

  def last?
    all?
  end

  def sale?
    all?
  end

  def soon?
    all?
  end

  def show?
    record.active? || user&.is_editor?
  end

  def index?
    user&.is_editor?
  end

  def new?
    user&.is_editor?
  end

  def create?
    user&.is_editor?
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

  def notification?
    true
  end

  def cart?
    user
  end

  class Scope < Scope
    def resolve
      if user&.is_editor?
        scope.all
      else
        scope.active
      end
    end
  end
end
