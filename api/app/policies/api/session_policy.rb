# frozen_string_literal: true

module Api
  class SessionPolicy < Api::ApplicationPolicy
    def show?
      true
    end

    def apple?
      true
    end
  end
end
