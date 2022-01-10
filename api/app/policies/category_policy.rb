class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (record.active? && record.variants_counter > 0) || user&.is_editor?
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

  class Scope < Scope
    def resolve
      if user&.is_editor?
        scope.all
      else
        scope.active.where.not(variants_and_kits_count: 0)
      end
    end
  end
end
