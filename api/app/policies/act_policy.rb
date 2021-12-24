class ActPolicy < ApplicationPolicy
  def create?
    user&.editor?
  end
end
