# frozen_string_literal: true

class KitPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    record.active?
  end

  def control?
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

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
