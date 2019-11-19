class StaticticPolicy < ApplicationPolicy
  def index?
    user&.is_editor?
  end
end
