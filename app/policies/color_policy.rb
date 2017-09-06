class ColorPolicy < ApplicationPolicy
  def index?
    create?
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
end
