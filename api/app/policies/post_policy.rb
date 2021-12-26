class PostPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def create?
    update?
  end

  def new?
    create?
  end

  def update?
    user&.is_editor?
  end

  def edit?
    update?
  end

  def destroy?
    user&.is_admin?
  end
end
