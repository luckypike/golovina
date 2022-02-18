# frozen_string_literal: true

module Api
  class ImagePolicy < Api::ApplicationPolicy
    def create?
      update?
    end

    def update?
      user&.editor?
    end

    def touch?
      create?
    end
  end
end
