# frozen_string_literal: true

module Api
  class VariantPolicy < Api::ApplicationPolicy
    def create?
      update?
    end

    def update?
      user&.editor?
    end
  end
end
