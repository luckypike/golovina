class ThemePolicy < ApplicationPolicy
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
end
