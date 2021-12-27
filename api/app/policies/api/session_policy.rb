# frozen_string_literal: true

module Api
  class SessionPolicy < Api::ApplicationPolicy
    def show?
      true
    end
  end
end
