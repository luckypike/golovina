# frozen_string_literal: true

module Api
  class VariantPolicy < Api::ApplicationPolicy
    def update?
      user&.is_editor?
    end
  end
end
