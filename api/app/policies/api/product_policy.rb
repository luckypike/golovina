# frozen_string_literal: true

module Api
  class ProductPolicy < Api::ApplicationPolicy
    def create?
      update?
    end

    def update?
      user&.is_editor?
    end
  end
end
