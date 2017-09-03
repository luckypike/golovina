class ImagePolicy < ApplicationPolicy
  def create?
    user&.is_editor?
  end

  def destroy?
    create?
  end
end
