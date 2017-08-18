class KitPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
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

  class Scope < Scope
    def resolve
      scope
    end
  end
end
