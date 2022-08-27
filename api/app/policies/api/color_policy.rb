# frozen_string_literal: true

module Api
  class ColorPolicy < Api::ApplicationPolicy
    def index?
      user&.editor?
    end

    def show?
      index?
    end

    def update?
      index?
    end

    def create?
      index?
    end
  end
end
