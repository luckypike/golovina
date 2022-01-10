# frozen_string_literal: true

module Api
  class ImagePolicy < Api::ApplicationPolicy
    def create?
      update?
    end

    def update?
      user&.is_editor?
    end

    def touch?
      create?
    end
  end
end
