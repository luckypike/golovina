class VariantPolicy < ApplicationPolicy
  def all?
    true
  end

  def wishlist?
    user
  end

  def cart?
    user
  end

  def latest?
    all?
  end

  def premium?
    all?
  end

  def last?
    all?
  end

  def sale?
    all?
  end

  def stayhome?
    all?
  end

  def morning?
    all?
  end

  # Recheck below

  def list?
    index?
  end

  def images?
    true
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

  class Scope < Scope
    def resolve
      if user&.editor?
        scope.all
      else
        scope.active
      end
    end
  end
end
