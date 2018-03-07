class CollectionPolicy < ApplicationPolicy
  def index?
    update?
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

  def new?
    create?
  end

  def create?
    update?
  end
end
