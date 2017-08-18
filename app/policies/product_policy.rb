class ProductPolicy < ApplicationPolicy
  def show?
    true
  end

  def all?
    create?
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

  class Scope < Scope
    def resolve
      scope
    end
  end
end
