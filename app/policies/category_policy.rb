class CategoryPolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    true
  end

  def update?
    user&.is_editor?
  end

  def edit?
    update?
  end

  def create?
    update?
  end

  def new?
    create?
  end

  def destroy?
    update?
  end
end
