class ImagePolicy < ApplicationPolicy
  def create?
    user&.is_editor?
  end

  def destroy?
    create?
  end

  def weight?
    create?
  end
end
