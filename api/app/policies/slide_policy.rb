class SlidePolicy < ApplicationPolicy
  def new?
    update?
  end

  def create?
    edit?
  end

  def edit?
    update?
  end

  def index?
    edit?
  end

  def update?
    user&.is_editor?
  end

  def destroy?
    user&.is_editor?
  end
end