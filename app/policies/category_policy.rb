class CategoryPolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    update?
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
end
