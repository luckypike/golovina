class ThemePolicy < ApplicationPolicy
  def index?
    show?
  end

  def show?
    true
  end
end
