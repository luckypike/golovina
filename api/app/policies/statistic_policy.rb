class StatisticPolicy < ApplicationPolicy
  def index?
    user&.editor?
  end
end
