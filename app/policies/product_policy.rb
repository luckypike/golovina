class ProductPolicy < ApplicationPolicy
  def control?
    create?
  end

  def show?
    true
  end

  def wishlist?
    user
  end

  def cart?
    user
  end

  def variants?
    update?
  end

  def index?
    category?
  end

  def all?
    category?
  end

  def create?
    update?
  end

  def new?
    create?
  end

  def category?
    true
  end

  def sale?
    category?
  end

  def latest?
    category?
  end

  def update?
    user&.is_editor?
  end

  def edit?
    update?
  end

  def publish?
    update?
  end

  def destroy?
    user&.is_admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
