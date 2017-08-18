class ImagePolicy < ApplicationPolicy
  def create?
    user.is_editor?
  end
end
