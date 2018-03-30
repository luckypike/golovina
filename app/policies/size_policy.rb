class SizePolicy < ApplicationPolicy

  def index?
    user&.is_editor?
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

  class Scope < Scope
    def resolve
      scope
    end
  end
end
